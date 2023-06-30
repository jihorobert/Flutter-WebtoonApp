import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 2, // 그림자
      ),
      // FutureBuilder : StateLess 에서도 가능 **********
      body: FutureBuilder(
        future: webtoons, // await 안써도됨(FutureBuilder 가 붙여줌)
        builder: (context, snapshot) {
          // snapshot : Future의 상태를 알 수 있음
          if (snapshot.hasData) {
            // Future가 완료돼서 데이터가 존재하면
            return const Text("There is data!");
          }
          return const Text("Loading...");
        },
      ),
    );
  }
}
