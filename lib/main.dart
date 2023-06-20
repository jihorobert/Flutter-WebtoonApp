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
   *////
  @override
  Widget build(BuildContext context) {    // Widget을 만들었으면 무조건 build를 만들어야됨

    /* root이니까 material이나 Cupertino (애플 디자인 시스템들) 둘중 하나를 return 해야됨
        주로 Material은 구글, Cupertino는 ios. (Material이 나음) */
    return MaterialApp(   // MatterialApplicationWidget을 return
      /** MaterialApp위에 올려놓으면 'Widget home' 뜸
       * 나머지도 마찬가지
       */
      home: Scaffold( // 우리 앱의 home에 있을때의 화면을 보여줌
        appBar: AppBar(
          title: Text("Hello Flutter!"),
        ),
        body: Center(     // class 작성을 끝낼때마다 ','를 항상 붙여줌(코드 정리해줄때 유용)
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
