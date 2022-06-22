import 'package:flutter/material.dart';

/// [Transform]
///
/// 화려한 애니메이션 (회전 등) 을 가능하게 만드는 위젯
/// 거의 모든 스마트폰에는 3D 그래픽에 최적화된 놀랍도록 빠른 GPU 가 포함되어 있음
/// 변환은 가환성이 없으므로 올바른 순서로 적용되어야 함.
/// 최종 완전한 행렬은 렌더링되는 객체를 변환하기 위해 GPU 로 전송됨
///
/// 각 로직 설명은 메서드 내용 참고
///
/// @see [https://youtu.be/9z_YNlRlWfA]
/// @see [https://api.flutter.dev/flutter/widgets/Transform-class.html]
/// @see [https://medium.com/flutter/perspective-on-flutter-6f832f4d912e]
///
/// 도랏맨 애니메이션 천지이다...
///
class TransformScreen extends StatelessWidget {
  const TransformScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform'),
      ),
      body: const TransformEntireWidget(),
    );
  }
}

class TransformEntireWidget extends StatefulWidget {
  const TransformEntireWidget({Key? key}) : super(key: key);

  @override
  _TransformEntireWidgetState createState() => _TransformEntireWidgetState();
}

class _TransformEntireWidgetState extends State<TransformEntireWidget> {
  int _counter = 0;

  // final Offset _offset = const Offset(0.4, 0.7); // new
  Offset _offset = Offset.zero; // changed

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        // Transform widget
        transform: Matrix4.identity()
          // 원근감을 구현 (perspective)
          // 행렬의 3행 2열을 0.001 로 설정하면 거리에 따라 사물이 축소됨
          // v (0.001)
          // 카메라의 줌 렌즈로 확대 및 축소하는 것과 같이 원근감의 양을 늘리거나 줄일 수 있음
          // 이 숫자가 클수록 원근감이 더 뚜렷해 보이는 물체에 더 가까이 있는 것처럼 보임

          // makePerspectiveMatrix() 내에는 우리가 필요로 하는 것보다 훨씬 더 많은
          // 화면비, 시야, 근거리 및 원거리 평면을 설정하기 위한 인수가 포함되어 있음
          // 이 인수들을 설정하여 행렬의 필수 요소를 직접 설정할 수 있음
          ..setEntry(3, 2, 0.001)

          // 회전은 축을 중심으로 정의되므로
          // rotateX는 Y(위-아래) 방향으로 기울어지는 X축을 중심으로 회전을 정의함
          // rotateY는 X(왼쪽-오른쪽) 방향(Y 축을 중심으로)으로 기울임
          //
          // 이것이 rotateX 가 _offset.dy 에 의해 제어되고 rotateY 가 _offset.dx 에 의해 제어되는 이유
          // ..rotateX(_offset.dy)
          // ..rotateY(_offset.dx),

          // 오프셋(픽셀 단위)이 0.01배 크기로 조정되어 회전(라디안 단위, 완전한 회전은 2π(약 6.28))에 더 잘 사용되도록 수정
          // 회전하려면 628픽셀의 팬 이동이 필요
          // 손가락 움직임에 다소 민감하게 만들기 위해 배율을 사용하여 재생할 수 있음
          ..rotateX(0.01 * _offset.dy) // changed
          ..rotateY(-0.01 * _offset.dx), // changed
        alignment: FractionalOffset.center,
        // child: _defaultApp(context),
        child: GestureDetector(
          // _offset에 팬 이동량(픽셀 단위)을 추가
          onPanUpdate: (details) => setState(() => _offset += details.delta),
          onDoubleTap: () => setState(() => _offset = Offset.zero),
          child: _defaultApp(context),
        ));
  }

  _defaultApp(BuildContext context) {
    // new
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Matrix 3D'), // changed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
