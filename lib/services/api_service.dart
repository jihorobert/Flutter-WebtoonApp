import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart'; // namespace this import

class ApiService {
  static const String baseURL =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  // package에 대한 정보를 찾고싶으면 pub.dev  ++) http api package 이용방법 : yaml에 적었음
  // async 이므로 함수타입을 Future로 감싸줘야함
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse("$baseURL/$today");
    /**
     * Dart가 이 부분이 제대로 완료될대까지 기다리기를 원함 -> async(비동기) programming
     * 여기서는 서버가 응답할때까지 프로그램을 기다리게 하기를 원함 (다음 줄의 코드로 넘어가지 않기를 원함)
     * await 이용 -> 위에 'async' 작성해야만 가능
     */
    // get 함수 = 미래에 완료되는 'Future', 끝나면 'Response'돌려줌
    final response =
        await http.get(url); // API 서버에 요청을 보냄, 응답을 기다림, response에 응답을 저장
    // 위 URL로 GET request를 하고싶음(위의 namespace 덕분에 http.get~ 로 할 수 있음)
    if (response.statusCode == 200) {
      // 200 : 성공
      // response의 body에는 서버가 보낸 데이터가 있음(디버그콘솔(jsonDecode대신 print를 썼을때)에 json형식으로 나타남)
      // jsonDecode -> JSON형식으로 바꿔줌
      // dynamic타입이라, 타입 정해줘야됨
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  /// 순서 정리
  /// 1) 기본 url 저장
  /// 2) 서버요청 후 응답저장
  /// 3) 응답 성공했으면 ~~

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseURL/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseURL/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
