import 'package:flutter/material.dart';

/// 'st' 입력하고 Flutter stateless ~~ 선택하면 금방됨.
/// 당분간은 직접 입력.

class Button extends StatelessWidget {
  /// Class 객체마다 바뀔값들 -> 변수로 선언
  final String text;
  final Color bgColor;
  final Color textColor;

  /// Constructor 직접 입력해도 되지만,
  /// 위 final에서 '전구' 눌러서 create constructor 가능
  const Button({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Text(
          // const위치가 Padding옆에 있었을때 에러났었음
          text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
