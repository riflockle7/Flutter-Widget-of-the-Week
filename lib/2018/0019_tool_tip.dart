import 'package:flutter/material.dart';

/// [Tooltip]
///
/// 길게 누를 때 메시지를 보여주거나 화면 판독기로 소리를 내어주는 위젯
/// (약간 불편한 사람들을 위한 위젯 같기도 함)
///
/// @see [https://youtu.be/EeEfD5fI-5Q]
/// @see [https://api.flutter.dev/flutter/material/Tooltip-class.html]
///
/// 말 그대로 tooltip.
/// 보통 길게 눌렀을 때(모바일), hover 상태일 때(웹) 해당 위젯이 나옴
/// 실제 사례는 잘 못 보았음 (굳이 이야기하면 하단탭 롱클릭?)
///
class TooltipScreen extends StatelessWidget {
  const TooltipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TooltipWidget();
  }
}

class TooltipWidget extends StatelessWidget {
  const TooltipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            DefaultTooltipWidget(),
            SizedBox(height: 10),
            ColorfulTooltipWidget(),
            SizedBox(height: 10),
            InlineSpanTooltipWidget(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

class DefaultTooltipWidget extends StatelessWidget {
  const DefaultTooltipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      message: 'I am a Tooltip',
      child: Text('Hover over the text to show a tooltip.'),
    );
  }
}

class ColorfulTooltipWidget extends StatelessWidget {
  const ColorfulTooltipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'I am a Tooltip',
      decoration: BoxDecoration(  // 배경 스타일 정하기
        borderRadius: BorderRadius.circular(25),
        gradient:
            const LinearGradient(colors: <Color>[Colors.amber, Colors.red]),
      ),
      height: 50,
      padding: const EdgeInsets.all(8.0),
      preferBelow: false, // 위로 출력
      textStyle: const TextStyle(fontSize: 24),
      showDuration: const Duration(seconds: 2),
      waitDuration: const Duration(seconds: 1),
      child: const Text('Tap this text and hold down to show a tooltip.'),
    );
  }
}

class InlineSpanTooltipWidget extends StatelessWidget {
  const InlineSpanTooltipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      richMessage: TextSpan(
        text: 'I am a rich tooltip. ',
        style: TextStyle(color: Colors.cyanAccent),
        children: <InlineSpan>[
          TextSpan(
            text: 'I am another span of this rich tooltip',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      child: Text('Tap this text and hold down to show a tooltip.'),
    );
  }
}
