import 'package:flutter/material.dart';

/// [Hero]
///
/// 두 경로(화면)에서 위치 차이를 감지하고 그만큼 변화한 위치에 대해 애니메이션을 수행
/// 두 경로(화면)에서는 사진의 정보를 모두 알고 있어야 함
///
/// 순서
/// 1. Hero 위젯으로 해당 이이템 위젯을 둘러싸기
/// 2. tag 추가하기 (두 화면에서 tag 명은 동일해야 함)
/// 3. 동작 시, Flutter 프레임워크는 먼저 영웅의 경계를 정의하는 직사각형 트윈인 [RectTween]을 계산함.
///    동작하는 동안 [Hero]는 애플리케이션 오버레이로 이동되어 두 경로의 상단에 나타남
///
/// 원리
/// 1. 전환전 전 화면에서 [Hero] 는 위젯 트리에서 기다림
/// 2. [Navigator.push] 실행 시, 애니메이션이 시작됨
///   1. 전 화면 [Hero] 는 offScreen 되고, 오버레이 영역이 생성됨
///   1. 곡선 모션을 사용하여 화면 밖에서 대상 [Hero] 까지의 경로를 계산함
///   2. 동일한 위치 및 크기의 오버레이에 [Hero] 를 배치함
///   3. 모든 경로 위에 나타나도록 z order 가 변경됨
/// 3. [Hero.createRectTween] 속성에 지정된 [Tween<Rect>] 를 사용하여 애니메이션이 실행됨
///   1. 기본적으로 Flutter 는 [MaterialRectArcTween] 의 인스턴스를 사용하여 곡선 경로를 따라 직사각형의 반대 모서리에 애니메이션을 적용
///   2. 오버레이 영역이 다음 화면 [Hero] 까지 이동하는 애니메이션이 실행됨
/// 4. 애니메이션이 종료될 때 [Hero] 위젯을 이동하며 이제 오버레이가 비어있게 됨
///   1. 전 화면 [Hero] 복원됨
///   2. 다음 화면 [Hero] 활성화되어 있음
///
///
/// @see [https://youtu.be/Be9UH1kXFDw]
/// @see [https://api.flutter.dev/flutter/widgets/Hero-class.html]
/// @see [https://docs.flutter.dev/development/ui/animations/hero-animations]
///
/// 안드에서 컨퍼런스로 나왔던 것을 flutter 에서는 매우 쉽....게 처리한다
/// tag 는 어떻게 통일 시킬지에 대한 이야기가 있었는데 이미지 resource 또는 원본 링크로 처리하는 게 기본적일듯
/// 이전 화면, 이후 화면 모두 [Hero] 명세가 필요함
///
class HeroScreen extends StatelessWidget {
  const HeroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero'),
      ),
      body: PhotoHero(
        photo: 'assets/images/flippers-alpha.png',
        width: 400.0,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Flippers Page'),
                ),
                body: Container(
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: PhotoHero(
                    photo: 'assets/images/flippers-alpha.png',
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
