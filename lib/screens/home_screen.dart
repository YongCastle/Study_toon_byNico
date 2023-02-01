import 'dart:developer';

import 'package:ex_webtoonapp/models/webtoon_model.dart';
import 'package:ex_webtoonapp/services/api_service.dart';
import 'package:flutter/material.dart';

import '../widgets/webtoon_widget.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final Future<List<WebtoonModel>> webtoons = APIservice.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //사용자가 보고 있는 데이터만 메모리에 남고 나머지는 메모리에 없음
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoons = snapshot.data![index];
        log(index.toString());
        return Webtoon(
          title: webtoons.title,
          thumb: webtoons.thumb,
          id: webtoons.id,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
