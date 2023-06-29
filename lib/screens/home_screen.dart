import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer;

  void onTick(Timer timer) {
    // 밑에 periodic은 인자로 Timer을 받아야하므로
    setState(() {
      totalSeconds -= 1;
    });
  }

  void onStartPressed() {
    /**
     * Duration동안에 (timer) {} 의 함수가 실행됨.
     */
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick, // 여기는 () 넣지않음. ()를 넣으면 바로 실행한다는 의미. Timer가 매초마다 괄호를 넣어서 실행해줌.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // UI를 비율에 기반해서 더 유연하게 만들 수 있게 해줌
          // 즉, Flexible은 하나의 박스가 얼마나 공간을 차지할 지 비율을 정해줌.
          Flexible(
            // 서로 간의 크기를 비교해서 얼마나 커야할지.(default 1)
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "$totalSeconds",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: onStartPressed,
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  // 맨밑의 container 맨 오른쪽까지 expand 시켜줌
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
