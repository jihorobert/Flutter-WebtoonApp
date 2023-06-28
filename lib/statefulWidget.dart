import 'package:flutter/material.dart';

/// Stateful Widget : 실시간 데이터의 변화를 보고싶을때 (Flutter에서 state를 이용해서 반은형/인터랙티브를 처리하는일은 드뭄. 다른방법이 있음)
/// /**
/// 1st부분 : 상태가 없는 위젯 그 자체
/// 2st부분 : 위젯의 상태 (state of the widget) (위젯에 들어갈 데이터와 UI를 넣는 곳)
///   -> 데이터가 바뀌면 ui도 같이 바뀐다는 뜻
///  */
/// 방법) 'st' 작성하고 자동완성, or statelessWidget을 StatefulWidget으로 convert

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState(); // 이게 전부
}

class _AppState extends State<App> {
  //int counter = 0; // overwrite 될 수 있어야 하므로 final이 아님
  List<int> numbers = [];
  // counter++; 여기에 써도 상관없음 but 밑이 가독성 높음
  void onClicked() {
    setState(() {
      /**
       * State에게 데이터가 변경되었다고 알리는 함수
       * 이 함수를 해야 실시간으로 데이터 변화됨.
       * 이 함수가 작동되면 build가 다시 작동되므로 counter는 0으로 초기화될 우려 X.
       */
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    // context에는 위젯 트리에 대한 정보가 담겨있고 매우 먼 부모요소로부터 데이터를 가져올 수 있게 해줌 (위젯의 위치에 대한 정보 알려줌)
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Click Count",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              for (var i in numbers)
                Text(
                  "$i",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              IconButton(
                iconSize: 40,
                onPressed: onClicked,
                icon: const Icon(
                  Icons.add_box_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatelessWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "My Large Title",
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
        /**
             * '!' -> null이 아님을 명확히 알려줌(titleLarge, color가 존재한다는 것을 명확히 알려줌)
             * '?' 도 가능
             * '!' -> im sure!!  '?' -> maybe
             */
      ),
    );
  }
}
