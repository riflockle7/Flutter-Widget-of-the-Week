import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// [CustomPaint], [CustomPainter]
///
/// [paint] 과정에서 그릴, 캔버스를 제공하는 위젯
///
/// 페인팅 과정
/// 1.페인팅을 요청하면 [CustomPaint] 는 먼저 [CustomPainter] 에게 현재 캔버스에 페인팅하도록 요청한 다음
///   자식을 페인팅한 다음 해당 아이를 페인팅한 후 전경 페인터에 페인팅하도록 요청
/// 2.캔버스의 좌표계는 [CustomPaint] 개체의 좌표계와 일치
///   painter 는 원점에서 시작하여 주어진 크기의 영역을 포함하는 직사각형 내에서 페인팅해야함.
///   (페인터가 해당 경계 외부에서 페인트하는 경우 페인팅 명령을 래스터화하는 데 할당된 메모리가 부족할 수 있으며 결과 동작이 정의되지 않을 수 있음
///   해당 경계 내에서 페인팅을 적용하려면 이 [CustomPaint] 를 [ClipRect] 위젯으로 래핑하는 것이 좋음)
///
/// [CustomPaint] 는 페인트 중에 해당 페인터를 호출하기 때문에, 콜백 중에 [State.setState] 또는 markNeedsLayout 을 호출할 수 없음(이 프레임의 레이아웃은 이미 발생했습니다).
/// [CustomPainter] 는 기본적으로 자식 위젯에 맞춰 너비 높이를 조정하며, 자식 위젯이 없을 시 [Size.zero]
///
/// @see [https://youtu.be/kp14Y4uHpHs]
/// @see [https://api.flutter.dev/flutter/widgets/CustomPaint-class.html]
/// @see [https://api.flutter.dev/flutter/rendering/CustomPainter-class.html]
/// @see [https://youtu.be/vvI_NUXK00s]
///
/// 기존 안드로이드에서 CustomView 만들고 draw 를 통해 canvas 에 직접 그림그리던 느낌이 났음
///
class CustomPaintScreen extends StatelessWidget {
  const CustomPaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPaint'),
      ),
      body: CustomPaint(
        painter: Sky(),
        child: const Center(
          child: Text(
            'Once upon a time...',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

/// 하늘 및 태양을 그리는 [CustomPainter]
class Sky extends CustomPainter {

  /// 그림을 그림
  /// 사용자 정의 개체를 다시 칠해야 할 때마다 호출됨
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.7, -0.6),
      radius: 0.2,
      colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
      stops: <double>[0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // "태양" 레이블로 태양 그림이 포함된 직사각형에 주석을 답니다.
      // 장치에서 TTS(텍스트 음성 변환) 기능이 활성화되면 사용자는 터치로 이 사진에서 태양을 찾을 수 있습니다.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  /// [CustomPainter] 가 다시 빌드될때 불려짐,
  /// 새 [CustomPainter] 인스턴스가 실제로 다른 정보를 나타내는지 확인
  /// 프레임워크에서 이전 페인트 결과를 재사용할 수 있도록 함
  @override
  bool shouldRepaint(Sky oldDelegate) => false;

  /// [CustomPainter] delegate 클래스의 새로운 인스턴스가 RenderCustomPaint 객체에 제공될 때마다
  /// 또는 [CustomPainter] delegate 클래스의 새로운 인스턴스로 새로운 [CustomPaint] 객체가 생성될 때마다 호출됨.
  ///
  /// 전자)의 관점에서 구현됩니다.
  ///
  /// 새 인스턴스로 인해 [semanticsBuilder] 가 다른 의미 체계 정보를 생성하는 경우 이 메서드는 true 를 반환해야 하고
  /// 그렇지 않으면 false 를 반환해야함 (false 인 경우 semanticsBuilder 호출이 최적화될 수 있음)
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}
