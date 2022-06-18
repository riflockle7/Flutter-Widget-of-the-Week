import 'package:flutter/material.dart';

/// [PageView]
///
/// swipeView!!
/// PageController
/// 1. 스와이프를 감지하고 애니메이션 제공
/// 2. PageView 내부 콘텐츠의 픽셀 오프셋을 제어, 뷰포트 크기의 증분인 페이지 측면에서 오프셋을 제어 가능
///
/// initialPage : 시작할 페이지 설정
/// 수직 스크롤을 하려면 scrollDirection 을 설정하면 됨
///
/// @see [https://youtu.be/J1gE9xvph-A]
/// @see [https://api.flutter.dev/flutter/widgets/PageView-class.html]
///
/// 기존의 ViewPager 와 똑같이 생각하면 될 것 같다.
/// 직접 사용해도 봤으니 별다른 실습은 하지 않을 예정
///
class PageViewScreen extends StatelessWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
      ),
      body: const PageViewWidget(),
    );
  }
}

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      controller: controller,
      children: const <Widget>[
        Center(
          child: Text('First Page'),
        ),
        Center(
          child: Text('Second Page'),
        ),
        Center(
          child: Text('Third Page'),
        )
      ],
    );
  }
}
