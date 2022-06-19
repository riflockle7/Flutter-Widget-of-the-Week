import 'package:flutter/material.dart';

/// [SliverAppBar]
///
/// 맞춤형 앱바 스크롤 효과를 만들 수 있게 도와주는 위젯
/// [CustomScrollView] 방식으로 앱 바에 맞춤식 스크롤 움직임을 제공함
/// ( = [CustomScrollView] 와 통합되는 머티리얼 디자인 [AppBar])
/// Sliver : 스크롤 가능한 일부분을 칭하는 단어
///
/// [SliverAppBar] 는 일반적으로 [CustomScrollView] 의 첫 번째 자식으로 사용됨
/// 이를 통해 [AppBar]는 스크롤 보기와 통합되어 스크롤 오프셋에 따라 높이가 달라지거나 스크롤 보기의 다른 콘텐츠 위에 플로팅 될 수 있음
/// 화면 상단의 고정 높이 앱 바는 [Scaffold.appBar] 슬롯에서 사용되는 [AppBar] 를 참조하십시오.
///
/// flexibleSpace 는 expandedHeight 변수와 함께 조절됨
/// flexibleSpace, expandedHeight 모두 다른 길이를 설정할 수 있음
/// floating 설정을 통해 위로 스크롤 시 [AppBar]가 보이도록 할 수 있음
///
/// @see [https://youtu.be/R9C5KMJKluE]
/// @see [https://api.flutter.dev/flutter/material/SliverAppBar-class.html]
/// @see [https://velog.io/@sharveka_11/Flutter-18.-SliverAppBar]
/// @see [https://velog.io/@sharveka_11/Flutter-19.-SliverList]
/// @see [https://velog.io/@sharveka_11/Flutter-20.-SliverGrid]
///
/// 개인적으로는 혁신 같음
/// 안드로이드에서 강아지 고생하여 구현했던 것을 여기서는 단순히 저걸로 쉽게 구현가능
/// (ex. floating, coordinatorLayout 등)
///
class SliverAppBarScreen extends StatefulWidget {
  const SliverAppBarScreen({Key? key}) : super(key: key);

  @override
  State<SliverAppBarScreen> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarScreen> {
  /// 해당 값이 활성화될 시, [AppBar] 가 활성화되어 있음
  bool _pinned = true;

  /// snap 이 true 인경우, 가려졌던 floating 이 한번에 보여짐
  /// snap 이 false 인 경우, 위치한 값에 따라 그만큼의 [AppBar] 가 펼쳐짐
  /// floating 이 false 일 경우엔 활성화될 수 없는 것으로 보임
  bool _snap = false;

  ///
  bool _floating = false;

  /// [SliverAppBar]는 일반적으로
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
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
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
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
            ),
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
