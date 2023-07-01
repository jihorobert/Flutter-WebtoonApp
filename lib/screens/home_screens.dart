import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // listView에 제한된 높이를 주기위해 expanded 이용
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            ); // Extract method 했음.
          }
          return const Center(
            child: CircularProgressIndicator(), // 로딩 기호
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // index : 특정 아이템이 build 됐다고 알려줌
        // 옆으로(Horizontal) scroll 해서 나오는 제목의 index가 print됨. 즉 화면ui에 보이는 제목의 index만 print됨.
        // 즉 한번에 모든 item들을 build 하지않음
        // print(index);
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        // 구분자
        width: 40,
      ),
    );
  }
}
