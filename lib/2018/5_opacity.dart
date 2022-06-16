import 'package:flutter/material.dart';

/// [Opacity]
///
/// 자식 위젯을 투명하게 만드는 위젯입니다. (투명도 세기는 정할 수 있음 : 0.0 ~ 1.0)
///
/// 원리 : 자식 위젯을 중간 버퍼에 칠한 다음, 부분적으로 투명한 장면에 자식 위젯을 다시 혼합함
/// 이 클래스는 자식을 중간 버퍼에 페인팅해야 하므로 0.0 및 1.0 이외의 투명도는 상대적으로 비용이 많이 듬
/// (값이 0.0 이면 자식이 전혀 그려지지 않음. 값 1.0의 경우 자식은 중간 버퍼 없이 즉시 그려짐)
///
/// 기본적으로 배경이 투명한 중간 버퍼가 있으면 일부 자식 위젯이 다르게 작동할 수 있음.
/// ex. [BackdropFilter] 자식 위젯은 이 위젯과 배경 자식 사이의 콘텐츠에만 필터를 적용할 수 있으며
/// 원하는 결과를 생성하려면 [BackdropFilter.blendMode] 속성을 조정해야 할 수 있음 (???)
///
/// 안티패턴
/// 1. [Opacity] 에 애니메이션을 적용하지 말 것
///   해당 위젯(및 해당 트리 아래 자식 위젯)이 각 프레임을 직접 재구성하므로 성능이 저하됨.
///   sol) [AnimatedOpacity] 또는 [FadeTransition] 을 사용할 것
///
/// 2. 단일 이미지 또는 색상만 0.0 에서 1.0 사이의 불투명도로 합성하는 경우
///   [Opacity] 위젯 사용하지 않는 것이 나음
///   ex. Container(color: [Color.fromRGBO] (255, 0, 0, 0.5)) > [Opacity] (opacity: 0.5, child: Container(color: Colors.red))
///
/// flutter 의 경우 위젯을 없에려면 rebuild 하면 됨
/// 위젯을 사라지게 하면서 저장공간에 남아있게하려면 활용해야하는 위젯
///
/// 변화하는 Opacity 를 적용하려면 [AnimatedOpacity] 도 있음
/// [AnimatedContainer] 와 비슷하게 duration 설정 필요
/// 리빌드 시, 애니메이션 실행
///
/// @see [https://youtu.be/9hltevOHQBw]
/// @see [https://api.flutter.dev/flutter/widgets/Opacity-class.html]
/// @see [https://api.flutter.dev/flutter/widgets/AnimatedOpacity-class.html]
///
/// 성능에 관련된 이야기가 있어서 좀 주의해서 사용해야 할듯
/// 색상만 바뀌는 경우엔 [Opacity] 사용하지 말자
///
class OpacityScreen extends StatelessWidget {
  const OpacityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opacity'),
      ),
      body: const OpacityWidget(),
    );
  }
}

class OpacityWidget extends StatefulWidget {
  const OpacityWidget({Key? key}) : super(key: key);

  @override
  State<OpacityWidget> createState() => _OpacityWidgetState();
}

class _OpacityWidgetState extends State<OpacityWidget> {
  bool _visible = true;
  bool _animatedVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _visible = !_visible;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Opacity(
                opacity: _visible ? 1.0 : 0.0,
                child: const Text("Now you see me, now you don't!"),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                _animatedVisible = !_animatedVisible;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _animatedVisible ? 1.0 : 0.0,
                child: const Text("Now you see me, now you don't!"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
