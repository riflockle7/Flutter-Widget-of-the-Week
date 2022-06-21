import 'package:flutter/material.dart';

/// [AbsorbPointer]
///
/// 포인터를 흡수하는 위젯
/// absorb 가 true 인 경우 이 위젯은 하위 트리가 포인터 이벤트를 수신하는 것을 아예 막음
/// 레이아웃 중에 여전히 공간을 소비하고 평소와 같이 자식을 그립니다.
/// [RenderBox.hitTest] 에서 true 를 반환하기 때문에 자식이 위치 이벤트의 대상이 되는 것을 방지합니다.
///
/// [IgnorePointer] 와는 다름
/// [IgnorePointer] 는 투과하지만, [AbsorbPointer] 는 아예 블로킹함
///
/// @see [https://youtu.be/65HoWqBboI8]
/// @see [https://api.flutter.dev/flutter/widgets/AbsorbPointer-class.html]
/// @see [https://stackoverflow.com/questions/55430842/flutter-absorbpointer-vs-ignorepointer-difference]
///
/// 음 예전에 xml 로 clickable, focusable 의 차이를 컨트롤하는 느낌도 든다
/// 그거 보다는 이게 훨씬 직관적인듯
///
class AbsorbPointerScreen extends StatelessWidget {
  const AbsorbPointerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AbsorbPointer'),
      ),
      body: Center(
        child: Column(
          children: const [
            AbsorbPointerWidget(),
            SizedBox(height: 20),
            IgnorePointerWidget(),
          ],
        ),
      ),
    );
  }
}

class AbsorbPointerWidget extends StatelessWidget {
  const AbsorbPointerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          height: 100.0,
          child: ElevatedButton(
            onPressed: () {
              print("가로가 긴 사각형");
            },
            child: null,
          ),
        ),
        SizedBox(
          width: 100.0,
          height: 200.0,
          child: AbsorbPointer(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade200,
              ),
              onPressed: () {
                print("세로가 긴 사각형");
              },
              child: null,
            ),
          ),
        ),
      ],
    );
  }
}

class IgnorePointerWidget extends StatelessWidget {
  const IgnorePointerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          height: 100.0,
          child: ElevatedButton(
            onPressed: () {
              print("가로가 긴 사각형");
            },
            child: null,
          ),
        ),
        SizedBox(
          width: 100.0,
          height: 200.0,
          child: IgnorePointer(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade200,
              ),
              onPressed: () {
                print("세로가 긴 사각형");
              },
              child: null,
            ),
          ),
        ),
      ],
    );
  }
}
