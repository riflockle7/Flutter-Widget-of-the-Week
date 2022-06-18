import 'package:flutter/material.dart';

/// [FloatingActionButton]
///
/// 약칭 FAB. 말 그대로 Floating 버튼
/// 하단 탭[BottomAppBar]에 플로팅 버튼 추가해야 하는 경우,
/// floatingActionButtonLocation 을 이용해 플로팅 버튼을 끼워넣을 수 있음
/// (endDocked, centerDocked)
///
/// "만들기", "공유" 또는 "탐색"과 같은 긍정적인 작업에 사용해야함
/// Route 내에서 하나 이상의 플로팅 작업 버튼이 사용되는 경우, 각 버튼에 고유한 heroTag 가 있는지 확인할 것.
/// 그렇지 않을 경우 예외가 발생
///
/// onPressed 콜백이 null 이면 버튼이 비활성화되고 터치에 반응하지 않음.
/// 버튼이 비활성화되어 있다는 표시가 사용자에게 없기 때문에 플로팅 작업 버튼을 비활성화하는 것이 좋음
/// 플로팅 작업 버튼을 비활성화하는 경우 backgroundColor 를 변경하는 것이 좋음
///
/// @see [https://youtu.be/2uaoEDOgk_I]
/// @see [https://api.flutter.dev/flutter/material/FloatingActionButton-class.html]
/// @see [https://api.flutter.dev/flutter/material/BottomAppBar-class.html]
///
/// 흔히 디자인에서 언급되는 하단에 버튼 넣기가 생각보다 쉽게 가능하다는 생각이 들었다.
/// 왼쪽 중간 오른쪽에 자유롭게 넣을 수 있는 것도 괄목할만한 내용인듯 하다.
/// StatelessWidget 으로 받으면서 특정 View 를 반환하는 케이스도 발견했는데 이 케이스도 커스텀 위젯을 만드는 사례로 인지하기!
///
class FloatingActionButtonScreen extends StatefulWidget {
  const FloatingActionButtonScreen({Key? key}) : super(key: key);

  @override
  State<FloatingActionButtonScreen> createState() =>
      _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<FloatingActionButtonScreen> {
  bool _showFab = true;
  bool _showNotch = true;

  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Floating Action Button'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 88),
          children: <Widget>[
            SwitchListTile(
              title: const Text('Show Floating Action Button'),
              value: _showFab,
              onChanged: _onShowFabChanged,
            ),
            SwitchListTile(
              title: const Text('Notch'),
              value: _showNotch,
              onChanged: _onShowNotchChanged,
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Floating action button position'),
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Docked - End'),
              value: FloatingActionButtonLocation.endDocked,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Docked - Center'),
              value: FloatingActionButtonLocation.centerDocked,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Docked - Start'),
              value: FloatingActionButtonLocation.startDocked,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Floating - End'),
              value: FloatingActionButtonLocation.endFloat,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Floating - Center'),
              value: FloatingActionButtonLocation.centerFloat,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
            RadioListTile<FloatingActionButtonLocation>(
              title: const Text('Floating - Start'),
              value: FloatingActionButtonLocation.startFloat,
              groupValue: _fabLocation,
              onChanged: _onFabLocationChanged,
            ),
          ],
        ),
        floatingActionButton: _showFab
            ? FloatingActionButton(
                onPressed: () {},
                tooltip: 'Create',
                child: const Icon(Icons.add),
              )
            : null,
        floatingActionButtonLocation: _fabLocation,
        bottomNavigationBar: _DemoBottomAppBar(
          fabLocation: _fabLocation,
          shape: _showNotch ? const CircularNotchedRectangle() : null,
        ),
      ),
    );
  }

  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch = value;
    });
  }

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  void _onFabLocationChanged(FloatingActionButtonLocation? value) {
    setState(() {
      _fabLocation = value ?? FloatingActionButtonLocation.endDocked;
    });
  }
}

/// [BottomAppBar] 를 반환하는 StatelessWidget
///
/// TODO 왜 StatelessWidget 으로 따로 만들어 [BottomAppBar] 를 반환하게 했을까?
///      단순 State 변경에 따라 view 의 움직임을 덜어주게 하려고 한걸까?
/// TODO 이벤트를 넣어주려면 함수를 넘겨주어야 될 거 같은데 그렇게 하는 게 맞을까?
class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> startLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.startFloat,
  ];
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            if (startLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
