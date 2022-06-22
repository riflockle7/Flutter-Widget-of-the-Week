import 'dart:math';

import 'package:flutter/material.dart';

/// [Align]
///
/// 부모 위젯의 한정된 구역 내에 위젯을 위치시키도록 하는 위젯
/// (선택적으로 자식의 크기에 따라 자체 크기를 조정하기도 함)
/// Alignment 에서는 -1 ~ 1 범위 명시
///
/// 이 위젯은 치수가 제한되고 widthFactor 및 heightFactor 가 null인 경우 가능한 한 커짐
/// 차원이 제한되지 않고 해당 크기 요소가 null 이면 위젯은 해당 차원의 자식 크기와 일치
/// 크기 요소가 null 이 아닌 경우 이 위젯의 해당 차원은 자식 차원과 크기 요소의 곱이 됨
/// ex. widthFactor = 2.0 -> 이 위젯의 너비는 항상 자식 너비의 두 배(2.0)
///
/// alignment 속성은 자식 좌표계의 한 점과 이 위젯의 좌표계에 있는 다른 점을 설명함
/// Align 위젯은 두 점이 서로의 위에 정렬되도록 자식을 배치함
///
/// [FractionalOffset]
/// 위의 [Alignment] 예제에서 사용된 '중심 지향 시스템' 과 달리,
/// '컨테이너의 왼쪽 상단 모서리에 원점' 이 있는 좌표 시스템을 사용
///
/// @see [https://youtu.be/g2E7yl3MwMk]
/// @see [https://api.flutter.dev/flutter/widgets/Align-class.html]
/// @see [other_link]
///
/// 나는 FractionalOffset 을 처음에 많이 쓸듯 (-1, 1 정신 없을듯...)
///
class AlignScreen extends StatelessWidget {
  const AlignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Align'),
      ),
      body: Column(
        children: const [
          AlignWidget(),
          SizedBox(height: 10),
          AlignFractionalWidget(),
        ],
      ),
    );
  }
}

class AlignWidget extends StatelessWidget {
  const AlignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.0,
        width: 120.0,
        color: Colors.blue[50],
        child: Align(
          alignment: Random().nextBool()
              ? Alignment.topRight
              : const Alignment(0.2, 0.6),
          // (0.2 * (FlutterLogo.width)/2 + (FlutterLogo.width)/2, 0.6 * (FlutterLogo.height)/2 + (FlutterLogo.height)/2) = (36.0, 48.0)
          child: const FlutterLogo(size: 60),
        ),
      ),
    );
  }
}

class AlignFractionalWidget extends StatelessWidget {
  const AlignFractionalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120.0,
        width: 120.0,
        color: Colors.blue[50],
        child: Align(
          alignment: Random().nextBool()
              ? Alignment.topRight
              : const FractionalOffset(0.2, 0.6),
          // (0.2 * (FlutterLogo.width), 0.6 * (FlutterLogo.height)) = (12.0, 36.0)
          child: const FlutterLogo(size: 60),
        ),
      ),
    );
  }
}
