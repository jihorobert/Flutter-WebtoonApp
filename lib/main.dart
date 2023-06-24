// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';

void main() {
  runApp(App()); // App()라는 클래스가 우리 앱의 시작점이라는 뜻(root라는뜻)
}

class App extends StatelessWidget {
  const App({super.key});

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
      /**
       * MaterialApp위에 마우스 올려놓으면 'Widget home' 뜸
       * 나머지도 마찬가지
       */
      home: Scaffold(
        // 우리 앱의 home에 있을때의 화면을 보여줌
        backgroundColor: Color(
            0x00181818), // Chrome 사이트에서 color를 pick해서 custom으로 이용 (ARGB이용 가능)
        body: Padding(
          // Padding 이용해서 모서리부분 공간생성
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // 'Total Balance' start쪽으로 옮김
            children: [
              SizedBox(
                height: 80,
              ),
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
              ),
              SizedBox(
                height: 120,
              ),
              Text(
                // 이 Text를 Container 혹은 Padding 안에 넣어야하면, 왼쪽에 나타나는 '전구' click해서 Wrap 할 수 있음.(단축기 command + .)
                "Total Balance",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "\$5 194 382",
                style: TextStyle(
                    fontSize: 47,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                /**
                 * 두개의 버튼(Transfer, Request) 사이 띄워놓음 (강의안보고 혼자했을때 : SizedBox 이용하려 했음)
                 */
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /**
                   * 밑에처럼 버튼 두개를 위해서 똑같은 형식의 Container를 복붙하지말고,
                   * Container 에서 '전구'이용해서 'Extract Widget' 선택 후, 이름 입력하면 됨.
                   * (맨 밑에 MyButton() 클래스 생김)
                   */
                  Button(
                    text: "Transfer",
                    bgColor: Colors.amber,
                    textColor: Colors.black,
                  ),
                  Button(
                    text: "Request",
                    bgColor: Color(0xFF1F2123),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
