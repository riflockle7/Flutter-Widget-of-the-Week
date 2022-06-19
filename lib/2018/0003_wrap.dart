import 'package:flutter/material.dart';

/// [Wrap]
///
/// 자식 위젯들을 수평 또는 수직으로 정렬하며, 오버플로우 시 다음 줄로 넘겨주는 위젯
///
/// 자식 위젯들은 주축의 정렬(direction) 설정에 따라 수평,수직 정렬됨
///
/// 정렬(alignment) 과 간격(spacing), 시작 간격(runSpacing) 속성 존재
///
/// @see [https://youtu.be/z5iw2SeFx2M]
/// @see [https://api.flutter.dev/flutter/widgets/Wrap-class.html]
///
/// tagView 정말 쉽게 만들 수 있을 것 같다.
///
class WrapScreen extends StatelessWidget {
  const WrapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wrap'),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            width: Size.infinite.width,
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [getVerticalWrap()],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [getHorizontalWrap()],
          ),
        ],
      ),
    );
  }

  /// 수직 정렬 wrap
  ///
  /// spacing : 수직 정렬이므로 세로 길이 (mainAxis)
  /// runSpacing : 수직 정렬이므로 가로 길이 (crossAxis)
  Widget getVerticalWrap() {
    return Wrap(
      direction: Axis.vertical,
      spacing: 4,
      runSpacing: 8,
      children: [for (int i = 0; i < 300; i++) generateItem(0xff00ff00)],
    );
  }

  /// 수평 정렬 wrap
  ///
  /// spacing : 수직 정렬이므로 가로 길이 (mainAxis)
  /// runSpacing : 수직 정렬이므로 세로 길이 (crossAxis)
  Widget getHorizontalWrap() {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 4,
      runSpacing: 8,
      children: [for (int i = 0; i < 300; i++) generateItem(0xff009fff)],
    );
  }

  Widget generateItem(int color) {
    return Text(
      "abcdefg",
      style: TextStyle(fontSize: 12, backgroundColor: Color(color)),
    );
  }
}
