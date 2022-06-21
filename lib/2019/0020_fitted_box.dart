import 'package:flutter/material.dart';

/// [FittedBox]
///
/// 특정 영역에 맞게 Widget 을 넣어주는 위젯
///
/// @see [https://youtu.be/T4Uehk3_wlY]
/// @see [https://api.flutter.dev/flutter/widgets/FittedBox-class.html]
///
/// ImageView 의 scalesType 생각하면 그대로 이해됨
/// 가능한 항목 내용은 [BoxFit] fit 명세에서 정의할 수 있는 내용 참고
///
class FittedBoxScreen extends StatelessWidget {
  const FittedBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FittedBox'),
      ),
      body: const FittedBoxWidget(),
    );
  }
}

class FittedBoxWidget extends StatelessWidget {
  const FittedBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: SizedBox(
        height: Size.infinite.width,
        width: Size.infinite.height,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        ),
      ),
    );
  }
}
