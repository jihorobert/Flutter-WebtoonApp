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
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

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
              showTitle ? const MyLargeTitle() : const Text("Nothing"),
              IconButton(
                onPressed: toggleTitle,
                icon: const Icon(
                  Icons.remove_red_eye,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  @override
  void initState() {
    // 오직 한번만 수행됨
    // 대부분의 상황에서는 필요없음. 그냥 위에 Int count = 0; 하면 됨
    // 종종 부모 요소에 의존하는 데이터를 초기화해야 하는 경우가 있음, 가끔 데이터를 초기화하기 위해 context를 사용해야하고, 종종 api에서 업데이트를 해야함
    // 이때 필요
    // 주요사항 : 항상 build method 전에 호출돼야함
    super.initState();
    print("initState");
  }

  @override
  void dispose() {
    // method used when the widget removed from the screen
    /**
     * 사용예시 :
     * API업데이트
     * 이벤트 리스너로부터 구독을 취소
     * form의 리스너로부터 벗어나고 싶을 때
     * **아무튼 취소하고하고싶을때(위젯이 위젯 트리에서 제거되기 전에 무언가를 취소하고 싶음)**
     */
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
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

/**
 * 핵심 : initState, build, dispose -> 이것을 widget lifecycle이라고 한다 라고 이해만 하고있으면됨.
 */