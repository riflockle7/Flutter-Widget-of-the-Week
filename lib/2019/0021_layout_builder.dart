import 'package:flutter/material.dart';

/// [LayoutBuilder]
///
/// 상위 위젯의 크기에 의존할 수 있는 위젯 트리
/// 프레임워크가 layout 시간에 builder()를 호출하고 상위 위젯의 제약 조건을 제공한다는 점을 제외하면 [Builder] 위젯과 유사함
/// 부모가 자식의 크기를 제한하고 자식의 본질적인 크기에 의존하지 않을 때 유용함
/// [LayoutBuilder] 의 최종 크기 = 자식 크기
///
/// builder() 함수가 호출되는 때
/// 1. 위젯이 처음 배치될 때
/// 2. 상위 위젯이 다른 레이아웃 제약 조건을 전달하는 경우
/// 3. 상위 위젯이 이 위젯을 업데이트할 때
/// 4. 빌더 함수가 구독하는 종속성이 변경되는 경우.
///
/// 자식이 부모보다 작아야 하는 경우 Align 위젯에서 자식을 감싸는 것을 고려하기
/// 자식이 더 커지길 원할 경우 [SingleChildScrollView] 또는 [OverflowBox] 로 감싸는 것이 좋음
///
/// @see [https://youtu.be/IYDVcriKjsw]
/// @see [https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html]
/// @see [other_link]
///
/// 동적인 뷰를 짤 때 괜찮아 보임, 반응형 처리 가능할 듯
///
class LayoutBuilderScreen extends StatelessWidget {
  const LayoutBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LayoutBuilder'),
      ),
      body: const LayoutBuilderWidget(),
    );
  }
}

class LayoutBuilderWidget extends StatelessWidget {
  const LayoutBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        print("constraints.maxWidth : ${constraints.maxWidth}");

        if (constraints.maxWidth > 400) {
          return _buildWideContainers();
        } else {
          return _buildSmallContainer();
        }
      },
    );
  }

  /// 350 보다 큰 경우
  Widget _buildWideContainers() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          ColoredBox(
            color: Colors.blue,
            child: SizedBox(
              height: 100.0,
              width: 100.0,
            ),
          ),
          ColoredBox(
            color: Colors.yellow,
            child: SizedBox(
              height: 100.0,
              width: 100.0,
            ),
          ),
        ],
      ),
    );
  }

  /// 350 보다 작은 경우
  Widget _buildSmallContainer() {
    return const Center(
      child: ColoredBox(
        color: Colors.red,
        child: SizedBox(
          height: 200.0,
          width: 200.0,
        ),
      ),
    );
  }
}
