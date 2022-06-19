import 'package:flutter/material.dart';

/// [Table]
///
/// 스크롤 가능한 격자 구조를 보여주고 싶을 때는 [GridView] 를 활용함
/// 스크롤 불가능한 격자 구조를 보여줄 때에 [Table] 을 사용
///
/// 사용자가 직접 행과 열을 크기 지정해 만들 필요가 없음
/// 크기를 재조정해 모든 내용을 포함하도록 만들 수 있음
///
/// 각 Row 에 들어가는 개수는 동일하여야 함 (틀리면 예외 발생)
///
///
/// @see [https://youtu.be/_lbE0wsVZSw]
/// @see [https://api.flutter.dev/flutter/widgets/Table-class.html]
/// @see [https://terry1213.github.io/flutter/flutter-widget-of-the-week-table/]
///
/// 스크롤 불가능한 격자 구조를 과연 쓸때는 있겠다만 글쎄....
/// 이렇게 사용하기 복잡해서 쉽게 적응할 수 있을까?
/// 그래도 세심하게 잘 활용하면 잘 써먹을 수 있을듯
///
class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table'),
      ),
      body: const TableWidget(),
    );
  }
}

class TableWidget extends StatelessWidget {
  const TableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),

      /// columnWidths : 각 index 마다 가중치를 부여함
      ///
      /// IntrinsicColumnWidth
      /// 세로줄에 해당하는 칸들의 크기에 따라 가로길이를 설정
      /// 해당 index 에 대해서는 적어도 하나에 width 가 적용되어 있어야 함
      /// (안 되어 있을 시 0 으로 인식되어 안 보임)
      /// 아래에서는 128 이므로 128 로 설정됨 (flex 값 넣을 시 그 배수만큼 증가함)
      ///
      /// FlexColumnWidth
      /// 다른 모든 열이 배치되면 나머지 공간의 일부를 기반으로 열 너비를 만듬
      /// 아래에서는 flex * 해당 index 라인 (세로줄)에서 최대 width, 고정픽셀(64) 만큼 뺀 나머지 길이
      ///
      /// FixedColumnWidth
      /// 고정 픽셀 부여
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(64),
      },
      /// defaultVerticalAlignment
      /// alignment 지정 안한 값들의 자식 위젯 기본 배치 방법
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              color: Colors.green,
            ),
            // width 를 적용하더라도 빼박 row 개수에 맞는 비율만 차지함
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
              ),
            ),
            Container(
              height: 64,
              color: Colors.blue,
            ),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          children: <Widget>[
            Container(
              height: 64,
              width: 128,
              color: Colors.purple,
            ),
            Container(
              height: 32,
              color: Colors.yellow,
            ),
            Center(
              child: Container(
                height: 32,
                width: 32,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
