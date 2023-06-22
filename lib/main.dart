// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(App()); // App()라는 클래스가 우리 앱의 시작점이라는 뜻(root라는뜻)
}

class App extends StatelessWidget {
  /* 3개의 core widget 중 하나 (build 메소드를 꼭 만들어야됨) 
      StatelessWidget : 그냥 무언가를 화면에 띄워주는 역할 */

  /** 
   * 여기있는 모든 class들(MaterialApp, Scaffold, AppBar, Text Center 등등)은 모두 앞에 'New'가 생략된것(dart기능)
   * 밑의 코드들 : 다트 class 강의에서 배운 'named constructor' *******
   * ex) String? name -> null일수있다 라는것 기억하기 *****
   */ ///
  @override
  Widget build(BuildContext context) {
    // Widget을 만들었으면 무조건 build를 만들어야됨

    /* root이니까 material이나 Cupertino (애플 디자인 시스템들) 둘중 하나를 return 해야됨
        주로 Material은 구글, Cupertino는 ios. (Material이 나음) */
    return MaterialApp(
      // MatterialApplicationWidget을 return
      /** MaterialApp위에 올려놓으면 'Widget home' 뜸
       * 나머지도 마찬가지
       */
      home: Scaffold(
        // 우리 앱의 home에 있을때의 화면을 보여줌
        backgroundColor: Color(
            0xFF181818), // Chrome 사이트에서 color를 pick해서 custom으로 이용 (ARGB이용 가능)
        body: Padding(
          // Padding 이용해서 모서리부분 공간생성
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Row(
                /**
                * Row에서의 'mainAxisalignment'는 수평방향, 'crossAxis~'는 수직. (Colomn은 그 반대)
                */
                mainAxisAlignment: MainAxisAlignment
                    .end, // Row에서의 'mainAxisalignment'는 수평방향 조종 (Column은 수직)
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "Hey, Selena",
                        style: TextStyle(
                          color: Colors
                              .white, // 칼라 팔레트 보려면 각 칼라 맨 우측 '>'누르면 됨(한번했더니 그이후로 자동)
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8), // 투명도 조절
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
