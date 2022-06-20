import 'package:flutter/material.dart';

/// [FadeInImage]
///
/// 대상 이미지가 로드되는 동안 placeHolder 이미지를 표시한 다음, 로드될 때 새 이미지를 fade in 하여 보여주는 이미지 위젯
/// [NetworkImage.new] 와 같이 로드시간이 긴 이미지 처리에도 적합 (이미지 로딩 후 자연스러운 애니메이션)
///
/// fadeOut 관련 : placeHolder 제어 / fadeIn 관련 : target Image 제어
/// 즉시 표시되도록 이미 캐시된 placeHolder 를 사용하여, 화면이 팝업처럼 보이는 걸 막음
///
/// 이미지가 변경되면 새 [ImageStream] 으로 확인됨
/// 새 [ImageStream.key] 가 다른 경우 이 위젯은 새 스트림을 구독하고
/// 표시된 이미지를 새 스트림에서 내보낸 이미지로 바꿈
///
/// placeHolder 가 변경되고 이미지가 아직 [ImageInfo] 를 내보내지 않은 경우
/// placeHolder 는 새 [ImageStream] 으로 확인됨
/// 새 [ImageStream.key] 가 다른 경우 이 위젯은 새 스트림을 구독하고
/// 표시된 이미지를 새 스트림에서 내보낸 이미지로 바꿈
///
/// 변경 후 이미지를 보여주기 전까지 이전의 이미지를 보여주는 걸 '갭리스 재생' 이라고 함
///
/// @see [https://youtu.be/pK738Pg9cxc]
/// @see [https://api.flutter.dev/flutter/widgets/FadeInImage-class.html]
/// @see [https://kibua20.tistory.com/235]
///
/// 유연한 처리가 가능해보여서 적극적으로 사용해보려고 함
/// [Curves] 에 있는 항목들을 숙지하는 데 좀 오래 걸릴 듯 (빌드해보면서 확인할 느낌)
///
class FadeInImageScreen extends StatelessWidget {
  const FadeInImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FadeInImage'),
      ),
      body: const FadeInImage(
        fadeOutDuration: Duration(milliseconds: 300),
        fadeOutCurve: Curves.elasticOut,
        fadeInDuration: Duration(milliseconds: 700),
        fadeInCurve: Curves.elasticIn,
        placeholder: NetworkImage(
            'https://www.bitrefill.com/content/cn/b_rgb%3AFFFFFF%2Cc_pad%2Ch_720%2Cw_1280/v1557913438/google.jpg'),
        image: NetworkImage(
            'https://www.google.co.kr/images/branding/googlelogo/2x/googlelogo_color_160x56dp.png'),
      ),
    );
  }
}
