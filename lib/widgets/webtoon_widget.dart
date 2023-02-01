import 'dart:developer';

import 'package:ex_webtoonapp/screens/detail_screen.dart';
import 'package:flutter/material.dart';

import '../route/slideBottomRouteex.dart';

class Webtoon extends StatelessWidget {
  final String title;
  final String thumb;
  final String id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SlideBottomRoute(
            page: Detailscreen(title: title, thumb: thumb, id: id),
          ),
        );
        log("onTap");
      },
      child: Column(
        children: [
          Hero(
            tag: id,
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
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
