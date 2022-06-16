import 'package:flutter/material.dart';

/// [Expanded]
///
/// 열과 행 또는 Flex 위젯 내에서, 하나의 자식 위젯만을 "확장"시킬 수 있는 위젯
/// (반응형 어플리케이션을 만들기 위해 사용하는 위젯)
///
/// 변경될 수 없는 내용을 먼저 나열하고, 변경될 수 있는 내용이 나머지 공간을 나누어 가짐
///
/// 행, 열 또는 Flex 의 자식 위젯이 기본 축을 따라 사용 가능한 공간을 채우도록 확장됨
/// (ex. Row 의 경우 가로, Column 의 경우 세로)
///
/// flex factor 로 공간 배열의 우선순위(prioritize) 를 결정함
///
/// 주의점
/// - Expanded 위젯은 행, 열 또는 Flex 의 자식 Widget 이어야 함
/// - Expanded 위젯에서 둘러싸는 행, 열 또는 Flex 까지의 경로에는 StatelessWidgets 또는 StatefulWidgets 만 포함되어야 함(??)
///
/// @see [https://youtu.be/_rnZaagadyo]
/// @see [https://api.flutter.dev/flutter/widgets/Flexible-class.html]
/// @see [https://api.flutter.dev/flutter/widgets/Expanded-class.html]
/// @see [https://seosh817.tistory.com/83]
///
/// 느낀점
/// 3번째 링크가 모든 것을 이야기하는 듯하다.
/// -> [Expanded] = [Flexible] (fit: [FlexFit.tight])
///
class ExpandedScreen extends StatelessWidget {
  const ExpandedScreen({Key? key}) : super(key: key);
  static const double fixedHeight = 50;
  static const bool useSingleChildScrollView = false;


  /// 참고 [ListView] 와 [SingleChildScrollView]
  ///
  /// 거의 컨텐츠로 다루어야 할 수준
  ///
  /// [ListView] 기능 명세
  /// - 선형으로 정렬된 스크롤 가능한 위젯
  /// - [NeverScrollableScrollPhysics] : 리스트뷰의 Scroll 을 무시하고 상위의 스크롤을 따름
  /// - shrinkWrap : true 일 시, [ListView] 가 필요한 공간만 차지하도록 함
  /// - 동적으로 그리므로 성능에서 약간 앞섬
  ///
  /// [SingleChildScrollView] 기능 명세
  /// - 자식 위젯을 하나만 가지면서 스크롤이 가능한 위젯
  /// - 유한 높이 제약 조건이 없음 (높이가 무한 - 당연한 것! 스크롤 가능해야 하니까)
  ///   (만약 자식 위젯에 Flex 또는 Expanded 를 설정하면 상호 베타적이므로 사용하지 말 것 - 알아서 에러 발생함)
  /// - 정적으로 모든 child 들을 그리므로 성능이 약간 떨어짐
  ///
  /// @see [https://stackoverflow.com/questions/45669202/how-to-add-a-listview-to-a-column-in-flutter]
  /// @see [https://www.youtube.com/watch?v=ZpHuAbYWL3w]
  /// @see [https://codekodo.tistory.com/97]
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expanded'),
      ),
      body: useSingleChildScrollView
          ? SingleChildScrollView(
              child: Column(
                children: [
                  getNonFlexibleWidget(),
                  getFlexibleWidget(200, FlexFit.loose),
                  getFlexibleWidget(50, FlexFit.tight),
                  getExpandedWidgetWithFlex(),
                  getExpandedWithListView(context)
                ],
              ),
            )
          : ListView(
              children: [
                getNonFlexibleWidget(),
                getFlexibleWidget(200, FlexFit.loose),
                getFlexibleWidget(50, FlexFit.tight),
                getExpandedWidgetWithFlex(),
                getExpandedWithListView(context)
              ],
            ),
    );
  }

  /// 0 - [Flexible] 을 사용하지 않아 오버플로우 에러가 나는 열 위젯
  Widget getNonFlexibleWidget() {
    return Row(
      children: const [
        ColoredBox(
            color: Color(0xff00ff00),
            child: SizedBox(width: 200, height: fixedHeight)),
        ColoredBox(
            color: Color(0xff112233),
            child: SizedBox(width: 300, height: fixedHeight)),
      ],
    );
  }

  /// 1, 2 - [Flexible] 을 사용하여 오버플로우 에러를 방지한 위젯 (최대 가능 영역까지만 확장)
  /// 1 : FlexFit.loose 을 통해 최대 가능 영역까지만 확장
  /// 2 : FlexFit.tight 을 통해 남은 영역을 전부 차지함 (as like [Expanded])
  Widget getFlexibleWidget(double firstWidth, FlexFit fit) {
    return Row(
      children: [
        ColoredBox(
            color: const Color(0xff009f00),
            child: SizedBox(width: firstWidth, height: fixedHeight)),
        Flexible(
          fit: fit,
          child: const ColoredBox(
              color: Color(0xff112233),
              child: SizedBox(width: 300, height: fixedHeight)),
        )
      ],
    );
  }

  /// 3 - flex 를 적용하여 자식 뷰에 비율 적용시키기
  ///
  /// TODO 왜 Container 을 넣을 땐 잘 나오고, SizedBox 를 넣으면 flex 가 잘 적용될까?
  Widget getExpandedWidgetWithFlex() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ColoredBox(
              color: const Color(0xff999f22),
              child: Container(height: fixedHeight)),
        ),
        Expanded(
          flex: 2,
          child: ColoredBox(
              color: const Color(0xff009f00),
              child: Container(height: fixedHeight)),
        ),
        Expanded(
          flex: 1,
          child: ColoredBox(
              color: const Color(0xff009fff),
              child: Container(height: fixedHeight)),
        )
      ],
    );
  }

  /// 4 - [Expanded] 내에 [ListView] 사용하기
  ///
  /// 사실상 불가능
  ///
  /// 1. [Expanded] 대신 [Flexible] 을 사용하여야 함
  ///    (스크롤 가능한 영역을 타이트하게 채운다는 건 무한대로 채운다는 의미)
  /// 2. shrinkWrap 를 반드시 true 로 해야함
  /// 3. 부분 스크롤이라면 [NeverScrollableScrollPhysics] 가 강제가 아니지만
  ///    전체를 잡는다면 가급적 [NeverScrollableScrollPhysics] 선언을 권장
  Widget getExpandedWithListView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 100,
          child: Text(
            "제목",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 28,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => generateRow(context, index),
          ),
        ),
        const SizedBox(
          height: 100,
          child: Text(
            "꼬리말",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 100,
          child: Text(
            "꼬리말",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 100,
          child: Text(
            "꼬리말",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  /// 한 줄에 보여줄 데이터를 만든다.
  Widget generateRow(BuildContext context, int index) {
    if (index == -1) {
      return Row(children: <Widget>[
        generateBorderText(context, 0.5, '시간 '),
        generateBorderText(context, 0.25, '평균 데시벨'),
        generateBorderText(context, 0.25, '피크 데시벨')
      ]);
    } else {
      return Row(children: <Widget>[
        generateBorderText(context, 0.5, "2022-06-16"),
        generateBorderText(context, 0.25, "0.33"),
        generateBorderText(context, 0.25, "1.33")
      ]);
    }
  }

  /// 스타일링된 텍스트뷰를 반환한다.
  Widget generateBorderText(BuildContext context, double ratio, String text) {
    return Container(
      width: MediaQuery.of(context).size.width * ratio,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
