import 'package:flutter/material.dart';

/// [ClipRRect]
///
/// 테두리를 둥글게 만들 수 있는 위젯
/// 특정한 렌더 객체를, 렌더 트리에서 그 자손 위에 삽입해서 작동
/// 재구성때마다 렌더 객체는 클립을 추가함
/// [ClipOval], [ClipPath] 도 존재
///
/// @see [https://youtu.be/eI43jkQkrvs]
/// @see [https://api.flutter.dev/flutter/widgets/ClipRRect-class.html]
/// @see [https://www.kindacode.com/article/examples-of-using-clipoval-in-flutter/]
/// @see [https://medium.com/flutter-community/flutter-custom-clipper-28c6d380fdd6]
///
/// 단순 radius 넣는 이미지 말고도 다른 쓸만한것들도 제법 있는 것 같다.
///
class ClipRRectScreen extends StatefulWidget {
  const ClipRRectScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ClipRRectState();
}

class ClipRRectState extends State<ClipRRectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClipRRect'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: ClipPathClipper(),
              clipBehavior: Clip.antiAlias,
              child: const ColoredBox(
                  color: Color(0x3300ff00),
                  child: SizedBox(width: 200, height: 200)),
            ),
            const SizedBox(height: 10),
            ClipOval(
              clipper: ClipOvalClipper(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: const ColoredBox(
                  color: Color(0x3300ff00),
                  child: SizedBox(width: 200, height: 200)),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const ColoredBox(
                  color: Color(0x3300ff00),
                  child: SizedBox(width: 200, height: 200)),
            )
          ],
        ),
      ),
    );
  }
}

/// Path 에 적용할 수 있는 내용은 아래 링크 참고
///
/// @see [https://miro.medium.com/max/1400/1*d8b4V3eknmGGuTvH2NaAxw.png]
class ClipPathClipper extends CustomClipper<Path> {
  /// 어떤 방식으로 둥글게 말 것인가에 대해 정한다.
  @override
  Path getClip(Size size) {

    Path path = Path()
      ..lineTo(0, size.height)          // Add line p1p2
      ..lineTo(size.width, size.height) // Add line p2p3
      ..close();

    return path;
  }

  ///  다시 클러퍼를 작동시켜야 하는지 여부를 알려준다.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipOvalClipper extends CustomClipper<Rect> {
  /// 어떤 방식으로 둥글게 말 것인가에 대해 정한다.
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: const Offset(0, 0), radius: 100);
  }

  ///  다시 클러퍼를 작동시켜야 하는지 여부를 알려준다.
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
