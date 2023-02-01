import 'package:ex_webtoonapp/models/webtoon_episode_model.dart';
import 'package:ex_webtoonapp/models/webtoondetail_model.dart';
import 'package:ex_webtoonapp/services/api_service.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatefulWidget {
  final String title;
  final String thumb;
  final String id;

  const Detailscreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webtoon = APIservice.getInfoToonById(widget.id);
    episodes = APIservice.getEpisodeById(widget.id);
  }

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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.id,
                child: Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                        color: Colors.red.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Image.network(widget.thumb),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            snapshot.data!.genre,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            snapshot.data!.age,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const Text('...');
            },
          )
        ],
      ),
    );
  }
}
