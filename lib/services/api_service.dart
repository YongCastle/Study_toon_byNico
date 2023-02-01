import 'dart:convert';

import 'package:ex_webtoonapp/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

import '../models/webtoon_episode_model.dart';
import '../models/webtoondetail_model.dart';

class APIservice {
  static const String baseURL =
      'https://webtoon-crawler.nomadcoders.workers.dev/';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseURL$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromjson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getInfoToonById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromjson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodeById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];

    final url = Uri.parse('$baseURL/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromjson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
