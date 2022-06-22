import 'dart:ui';

import 'package:flutter/material.dart';

/// [BackdropFilter]
///
/// 기존에 그려진 콘텐츠(자식 위젯)에 필터를 적용한 다음, 자식을 페인팅하는 위젯
/// [BackdropFilter], [ImageFilter] 를 활용하면 블러 처리, 이미지 회전, 각도 조절 등을 할 수 있음
///
/// 필터는 상위 또는 상위 위젯의 클립 내의 모든 영역에 적용되며, 클립이 없으면 필터가 전체 화면에 적용
///
/// 원하는 필터 (blur, matrix 등) 을 선택하고, child 위젯을 통해 필터 적용할 위젯을 설정하기
/// 배경에 필터를 적용해 그림을 보이지 않게 하려면, child 에 빈 컨테이너 적용해보기
/// 부분 처리도 가능
///
/// 필터의 결과는 blendMode 매개변수를 사용하여 배경으로 다시 혼합됨
/// 모든 플랫폼에서 지원되는 blendMode 의 유일한 값은 대부분의 장면에서 잘 작동하는 BlendMode.srcOver
/// 그러나 그 값은 BackdropFilter 의 부모가 Opacity 위젯과 마찬가지로 임시 버퍼 또는 저장 레이어를 사용할 때 놀라운 결과를 생성할 수 있음
/// 이러한 상황에서 BlendMode.src 값은 더 만족스러운 결과를 생성할 수 있지만, 일부 플랫폼 (특히 웹 응용 프로그램용 html 렌더러) 와의 비호환성을 감수해야 함
///
/// [BlendMode] : 캔버스에 그림을 그릴 때 사용할 알고리즘
/// 알고리즘 목록은 해당 링크[https://api.flutter.dev/flutter/dart-ui/BlendMode.html] 참고
///
/// @see [https://youtu.be/dYRs7Q1vfYI]
/// @see [https://api.flutter.dev/flutter/widgets/BackdropFilter-class.html]
/// @see [https://api.flutter.dev/flutter/dart-ui/BlendMode.html]
///
/// 기존에 안드로이드에선 어떻게 했더라...
/// 일종의 블루프린트를 이렇게 처리해버리넴....
///
class BackdropFilterScreen extends StatelessWidget {
  const BackdropFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackdropFilter'),
      ),
      body: const BackdropFilterWidget(),
    );
  }
}

class BackdropFilterWidget extends StatelessWidget {
  const BackdropFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Text('0' * 10000),
        Center(
          child: ClipRect(
            child: BackdropFilter(
              blendMode: BlendMode.srcOver,
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: const SizedBox(
                width: 200.0,
                height: 200.0,
                child: Center(
                  child: Text('Hello World'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
