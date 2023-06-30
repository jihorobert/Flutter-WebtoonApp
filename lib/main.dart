import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screens.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  // 이 위젯의 key를 stateless widget이라는 슈퍼클래스에 보냄
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
