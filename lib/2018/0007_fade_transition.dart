import 'package:flutter/material.dart';

/// [FadeTransition]
///
/// 동작, 효과를 추가하는 강력한 애니메이션 엔진
/// 위젯의 불투명도를 애니메이션하며, 대표적으로 fade in, fade out 을 할 수 있음
///
/// (두 자식의 크기 사이에 자동으로 애니메이션 효과를 주고 그 사이에서 페이드하는 위젯에 대해서는 [AnimatedCrossFade] 참고하기)
///
/// Animation 시작 단계
/// 1. Controller 인스턴스를 만들어 지속시간 설정
/// 2. 시작 및 종료에 불투명도 부여 후 애니메이션 만듬
/// 3. 마지막으로 Controller 인스턴스를 불러와 애니메이션 시작
///
/// FadeTransition 은 위젯의 상태를 관리 및 다시 정리해 줌
///
/// @see [https://youtu.be/rLwWVbv3xDQ]
/// @see [https://api.flutter.dev/flutter/widgets/FadeTransition-class.html]
/// @see [https://codeprinter.tistory.com/2?category=1160722]
///
/// TODO [TickerProviderStateMixin] 와 vsync:this 아직은 명확히 이해가 안된다.
/// TODO [Ticker] 는 뭘로 이해하는 게 나으려나
/// TickerMode : 위젯 하위 트리에서 티커 (및 애니메이션 컨트롤러)를 활성화하거나 비활성화합니다.
/// 애니메이션은 직접 부딪히면서 해봐야 좀 이해가 될듯함
///
class FadeTransitionScreen extends StatelessWidget {
  const FadeTransitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FadeTransition'),
      ),
      body: const FadeTransitionWidget(),
    );
  }
}

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({Key? key}) : super(key: key);

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

/// [TickerProviderStateMixin] 때문에 'vsync: this' 로 [AnimationController] 를 생성할 수 있음
///
/// [SingleTickerProviderStateMixin]
/// [TickerMode] 에 의해 정의된 대로 트리가 활성화 된 동안에만 틱 하도록 구성된 단일 티커를 제공
///
/// [TickerProviderStateMixin]
/// 한 개의 [AnimationController] 를 사용할 때만 사용하고
/// 만약 다중 [AnimationController] 를 사용한다면 이것이 아니라 [TickerProviderStateMixin] 을 사용
///
/// [AnimationController]
/// 애니메이션 속도를 조절하는 구동부
///
/// [Animation]
/// 전체 애니메이션
class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    super.initState();
    print("_FadeTransitionWidgetState initState");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_FadeTransitionWidgetState build");
    return SizedBox(
      child: Column(
        children: [
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: const Padding(
                  padding: EdgeInsets.all(8), child: FlutterLogo()),
            ),
          ),
          const SignUpForm(),
        ],
      ),
    );
  }
}

/// 회원가입 입력 폼
///
/// TODO [StateFulWidget] 형태로 커스텀 위젯을 만들어 처리함으로서, setState 시 build 하는 범위를 줄인다.
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  @override
  void initState() {
    super.initState();
    print("_SignUpFormState initState");
  }

  /// [Form]
  ///
  /// [Form] 자식 위젯들의 controller 를 observe 하여, onChanged 가 동작하는 듯함
  /// -> 실제 그런듯 (양식 필드 중 하나가 변경될 때 호출됩니다.)
  ///
  @override
  Widget build(BuildContext context) {
    print("_SignUpFormState build");
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _formProgress == 1 ? () => print('회원가입 요청') : null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }
}

/// 상단 ProgressIndicator
class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  /// widget : 해당 state 를 가지고 있는 widget
  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}
