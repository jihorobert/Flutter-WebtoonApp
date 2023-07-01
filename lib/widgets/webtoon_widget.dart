import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Container(
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
    );
  }
}
