import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;
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
        // onTap : 클릭했을때
        // 스크린을 바꾸기 위해
        // route : DetailScreen 같은 StatelessWidget을 애니메이션효과로 감싸서 스크린처럼 보이게함
        Navigator.push(
          // 다른 스크린으로 갔다는 것을 알게 해주는 애니메이션효과
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              // builder : to build the route
              title: title,
              thumb: thumb,
              id: id,
            ),
            fullscreenDialog: true, // 화면 넘어가는 방식이 달라짐(밑에서 올라옴)
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // 'detail_screen.dart'에 있는 다른 Hero와 Tag를 이용해서, 화면 넘어가면서 'image'를 연결시켜줌
            tag: id,
            child: Container(
              // 꾸밀거기 때문에 container 이용
              clipBehavior: Clip.hardEdge, // 이거 해줘야 borderradius 적용됨
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    // 팁 : 처음 shadow 색깔 red로 해서 크기맞추기
                    BoxShadow(
                      // 그림자
                      blurRadius: 7,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]),
              width: 250,
              child: Image.network(
                thumb,
              ),
            ),
          ), // 썸네일의 이미지 추가
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
