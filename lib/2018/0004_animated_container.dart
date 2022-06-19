import 'package:flutter/material.dart';

/// [AnimatedContainer]
///
/// [Container] 의 Animation 이 있는 위젯
///
/// 비명시적 애니메이션을 위한 위젯
/// ex1. 색상 선형보간법 (차차 색이 바뀜)
/// ex2. 테투리, 테두리 반경, 배경 이미지, 패딩, 폭 높이 등도 가능
///
/// duration 을 통해 애니메이션 시간 조절
/// curve 를 통해 임의 Curves 적용 가능
/// (적용가능한 Curves 는 [Curves] 정의 참고)
///
/// @see [https://youtu.be/yI-8QHpGIP4]
/// @see [https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html]
///
/// [StatefulWidget] 의 [State.setState] 을 활용하여, 애니메이션을 하는듯한 느낌
///
class AnimatedContainerScreen extends StatelessWidget {
  const AnimatedContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('[제목]'),
      ),
      body: const AnimatedContainerWidget(),
    );
  }
}

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: AnimatedContainer(
          width: selected ? 200.0 : 100.0,
          height: selected ? 100.0 : 200.0,
          color: selected ? Colors.red : Colors.blue,
          alignment:
              selected ? Alignment.center : AlignmentDirectional.topCenter,
          duration: const Duration(seconds: 2),
          child: const FlutterLogo(size: 75),
        ),
      ),
    );
  }
}
