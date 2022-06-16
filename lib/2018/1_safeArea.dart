import 'package:flutter/material.dart';

/// SafeArea
///
/// 운영 체제의 침입을 피하기 위해 충분한 패딩으로 자식을 삽입하는 위젯
/// (ex. 화면 상단의 상태 표시줄을 피할 수 있을 만큼, iPhone X의 Notch 또는 디스플레이의 기타 유사한 창의적 물리적 기능을 피할 수 있을 만큼 child 를 들여씀)
///
/// MediaQuery 로 화면과 가장자리의 면적을 측정한 후 앱의 화면을 알맞게 맞추어 줌
/// iOS 와 안드로이드 환경에서 콘텐츠를 보호해줌
///
/// @see https://api.flutter.dev/flutter/widgets/SafeArea-class.html
///
/// 전체화면을 잡아야 하는 경우엔 무조건 써야할듯
/// 그런데 효과는 음.., 솔직히 말해서 잘 모르겠음
/// android 에서는 저런 뷰가 잘 안나오기도 하고 네비게이션을 활성화하고 보아도 일부 글자는 가려짐
/// iOS 의 특이점때문에 작성된 내용인듯 하여 일단은 그렇구나 하고 넘어가야 할듯....
///
class SafeAreaScreen extends StatelessWidget {
  const SafeAreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
            Text("The Text is obscured!"),
          ],
        ),
        top: true,
        bottom: true,
        left: false,
        right: true,
      ),
    );
  }
}
