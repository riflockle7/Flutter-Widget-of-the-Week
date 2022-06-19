import 'package:flutter/material.dart';

/// [SliverList], [SliverGrid]
///
/// Sliver(복습) : 스크롤 가능한 영역
/// Sliver 에서는 개별 항목을 뷰를 스크롤하면서 손쉽게 만들 수 있음
///
/// [SliverList] 원리
/// [SliverList] 는 슬라이버의 보이는 부분 외부에 있는 자식이 구체화되지 않기 때문에
/// "데드 레커닝(dead reckoning)"에 의해 스크롤 오프셋을 결정함.
/// 대신 새로 구체화된 자식이 기존 자식에 인접하게 배치됨
/// 데드 레커닝 = 추측하여 갱신
///
/// 자식의 기본 축에 고정 범위가 있는 경우 [SliverFixedExtentList] 를 추천함
/// [SliverFixedExtentList]는 기본 축에서 범위를 얻기 위해 자식에 대한 레이아웃을 수행할 필요가 없음
/// 그러므로 [SliverList]보다 [SliverFixedExtentList]를 사용하는 것이 좋음 (const 개념으로 장점이 있는듯)
///
/// 자식 위젯 생명주기
/// 1. 생성
///   목록이 배치되는 동안 보이는 자식 요소, 상태 및 렌더링 개체는
///   기존 위젯([SliverChildListDelegate]) 또는 느리게 제공된 위젯([SliverChildBuilderDelegate])을 기반으로 느리게 생성됨
/// 2. 파괴
///   보이지 않는 view 들은 연결된 요소 하위 트리, 상태 및 렌더링 개체가 파괴됨
///   슬라이버의 동일한 위치에 있는 새 자식은 뒤로 스크롤할 때 새 요소, 상태 및 렌더링 개체와 함께 느리게 다시 생성됨
/// 3. 파괴 완화
///   자식 요소가 보기 안팎으로 스크롤될 때 상태를 유지하기 위해 다음 옵션이 가능함
///   1. 하위 위젯에 StateFulWidget 을 두어 해당 자식 내에서의 State 를 저장하여 그대로 불러오도록 하기(???)
///   2. [KeepAlive] 를 통해 처리하기
///      KeepAlive 는 keepalive 에 대한 자식 하위 트리의 최상위 렌더링 개체 자식을 표시함
///      연결된 상위 렌더 개체가 보기에서 스크롤되면 슬라이버는 자식의 렌더 개체(및 확장하여 연결된 요소 및 상태)를 삭제하는 대신 캐시 목록에 유지함
///      뷰로 다시 스크롤하면 렌더 개체가 있는 그대로 다시 칠해짐 (재사용)
///
///      주의
///      SliverChildDelegate 하위 클래스가 addAutomaticKeepAlives 및 addRepaintBoundaries를 통해
///      AutomaticKeepAlive 및 RepaintBoundary 와 같은 다른 위젯으로 하위 위젯의 하위 트리를 래핑하지 않는 경우에만 작동(???)
///
///   3. [AutomaticKeepAlive] 사용하기 (기본적으로 [SliverChildListDelegate] 또는 [SliverChildListDelegate] 에 삽입됨)
///      AutomaticKeepAlive 를 사용하면 하위 위젯이 하위 트리가 실제로 활성 상태로 유지되는지 여부를 제어할 수 있음
///      이 동작은 하위 트리를 무조건 활성 상태로 유지하는 [KeepAlive] 와 대조됩니다.
///      ex. EditableText 위젯은 텍스트 필드에 입력 포커스가 있는 동안 활성 상태를 유지하도록 Sliver 하위 요소 하위 트리에 신호를 보냄.
///          포커스가 없고 KeepAliveNotification 을 통해 keepalive 신호를 받은 다른 자손이 없는 경우
///          스크롤할 때 슬라이버 자식 요소 하위 트리가 파괴됨
///
/// delegate
/// 뷰를 스크롤하면서 항목을 제공함
/// [SliverChildListDelegate] 로 하위요소 항목 명시 가능
/// [SliverChildBuilderDelegate] 로도 만들 수 있음
///
/// 각 delegate 의 첫 번째 자식 위젯은 현재 볼 수 있는 영역을 넘어 확장되더라도 항상 배치됨
/// 현재 빌드된 자식을 사용하여 나머지 자식을 추정하기 때문에, estimateMaxScrollOffset 을 추정하려면 하나의 자식은 반드시 필요함
///
/// grid 인 경우에는 crossAxis 측정 기준에 추가 서식이 필요함
/// ex. Sliver.count 를 통해 개수 정의, Sliver.extent 로 항목의 최대폭 명시
///
/// @see [https://youtu.be/ORiTTaVY6mM]
/// @see [https://api.flutter.dev/flutter/widgets/SliverGrid-class.html]
/// @see [https://api.flutter.dev/flutter/widgets/SliverList-class.html]
///
/// TODO [SliverPersistentHeaderDelegate] 는 무조건 상속받는 클래스 구현체로 해야하나?
/// TODO [SliverPersistentHeader] 가 pinned 이거나 보여지거나 가려질때 높이 변경 유연하게 할 수 있는 방법 고민해보기
/// 추측하여 갱신하는 것과, 자식 위젯 생명주기는 기억해도 좋을듯 (as like recyclerView)
/// delegate 관련해서 심오한 내용들이 좀 있는 것 같다
/// [KeepAlive], [AutomaticKeepAlive] 에 대해 나중에 조사해볼 필요가 있어보임
///
class SliverListGridScreen extends StatefulWidget {
  const SliverListGridScreen({Key? key}) : super(key: key);

  @override
  State<SliverListGridScreen> createState() => _SliverListGridWidgetState();
}

class _SliverListGridWidgetState extends State<SliverListGridScreen> {
  /// 해당 값이 활성화될 시, [AppBar] 가 활성화되어 있음
  bool _pinned = true;

  /// snap 이 true 인경우, 가려졌던 floating 이 한번에 보여짐
  /// snap 이 false 인 경우, 위치한 값에 따라 그만큼의 [AppBar] 가 펼쳐짐
  /// floating 이 false 일 경우엔 활성화될 수 없는 것으로 보임
  bool _snap = false;

  /// 앱바가 가려졌다가 보여졌다가 하는지 여부
  bool _floating = false;

  /// [SliverListGrid]는 일반적으로
  /// [CustomScrollView.slivers] 에서 사용되며
  /// [Scaffold.body]에 배치될 수 있음
  ///
  /// flexibleSpace 은 [FlexibleSpaceBar] 위젯 사용을 권장하는 듯 함
  /// [SliverToBoxAdapter] 은 그냥 빈 공간인듯
  /// [SliverList] : 일반 리스트뷰
  /// [SliverFixedExtentList] : itemExtent 를 통해 최대 높이를 갖는 리스트뷰
  /// [SliverPrototypeExtentList] : 각 아이템들이 기본 축을 따라 프로토타입 항목과 동일한 범위를 갖도록 제한하는 리스트뷰
  /// [SliverGrid] : 일반 그리드뷰
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          SliverPersistentHeader(
            delegate: OurDelegate(
              toolBarHeight: MediaQuery.of(context).padding.top,
              openHeight: _pinned ? 250 + 160 : 250,
              closedHeight: _pinned ? 240 + 160 : 240,
            ),
            pinned: true,
            floating: true,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect2.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              for (int index = 0; index < 30; index++)
                Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                )
            ]),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OurDelegate extends SliverPersistentHeaderDelegate {
  double toolBarHeight;

  //toolBarHeight Included in both
  double closedHeight;
  double openHeight;

  OurDelegate({
    required this.toolBarHeight,
    required this.closedHeight,
    required this.openHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: toolBarHeight + openHeight,
      color: Theme.of(context).primaryColorDark,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 64,
          ),
          child: const FittedBox(
            fit: BoxFit.contain,
            child: Text("Workouts"),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => toolBarHeight + openHeight;

  @override
  double get minExtent => toolBarHeight + closedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
