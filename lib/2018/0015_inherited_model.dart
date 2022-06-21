import 'dart:math';

import 'package:flutter/material.dart';

/// [InheritedModel]
///
/// [InheritedWidget] 과 사실상 동일한 내용
///
/// [InheritedWidget]
/// [InheritedWidget] 은 .of()형태를 이용하여 상태에 대하여 참조함
/// ex. MediaQuery.of(context).size.width : 현재 위치의 가로 사이즈
/// 해당 위젯은 가지고 있는 상태의 변경에 따라서, 상태의 변경에 대한 알림을 하위 위젯들에게 할지 말지 결정하는 위젯
///
/// react 를 이해한다면 바로 이해가능할 수 있음
/// flutter 도 react 와 비슷하게 tree 구조 (위에서 아래로 내려주는 식)
/// 위로 올려주고, 아래로 내려주는 게 필요함 (react 에는 context API, redux 라는 개념이 존재함)
/// angular 나 vue 는 양방향 바인딩이 된다고 함
/// 단방향 바인딩의 단점 : 코딩량이 만만치 않아짐
///
/// Widget 은 다같이 변경, Model 은 조건문을 태움 (ex. 어느 하위 위젯을 변경시킬건지 등)
///
///
/// @see [https://youtu.be/ml5uefGgkaA]
/// @see [https://api.flutter.dev/flutter/widgets/InheritedModel-class.html]
/// @see [https://lucky516.tistory.com/124]
/// @see [https://www.youtube.com/watch?v=8kWnpn0AHmo]
///
/// 상태 관리 성능을 위해 사용되는 위젯으로 보임
/// 알게 모르게 사용하는 위젯은 모두 [InheritedWidget]
/// ex. Scaffold 위젯, Theme 위젯, FocusScope 위젯
///
/// 아래 예제는 [InheritedModel] 에 정의된 내용에 따라 부분 reBuild 를 하도록 만든 예제
///
class InheritModelScreen extends StatefulWidget {
  const InheritModelScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InheritModelState();
  }
}

class InheritModelState extends State<InheritModelScreen> {
  Color _colorOne = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  Color _colorTwo = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedModel'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AncestorWidget(
            _colorOne,
            _colorTwo,
            Column(
              children: const [
                DependentWidgetOne(),
                DependentWidgetTwo(),
              ],
            ),
          ),
          Row(
            children: [
              MaterialButton(
                child: const Text(
                  'Reset Child 1',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    _colorOne = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                  });
                },
              ),
              MaterialButton(
                child: const Text(
                  'Reset Child 2',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    _colorTwo = Colors
                        .primaries[Random().nextInt(Colors.primaries.length)];
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

/// @see [https://velog.io/@knh4300/StateManagement#inheritedwidget]
class AncestorWidget extends InheritedModel<String> {
  const AncestorWidget(this.colorOne, this.colorTwo, Widget child, {Key? key})
      : super(key: key, child: child);

  final Color colorOne;
  final Color colorTwo;

  /// 하위 Widget 에서 최상단 Widget(여기에서는 [AncestorWidget]) 정보를 알 수 있도록 함
  static AncestorWidget of(BuildContext context, String aspect) {
    return InheritedModel.inheritFrom<AncestorWidget>(context, aspect: aspect)!;
  }

  /// 하위 Widget 에서 해당 [InheritedModel] 정보를 알 수 있도록 함
  ///
  /// [InheritedWidget] 이 어떠한 이유로 인해 update 되었을 때 (= setState 호출했을때?),
  /// 이 [InheritedWidget] 에 의존하는 [Widget] 을 rebuild 할 지 결정하는 함수
  // (위젯들에게 변경 내용을 노티해야 하는지...)
  @override
  bool updateShouldNotify(covariant AncestorWidget oldWidget) {
    return colorOne != oldWidget.colorOne || colorTwo != oldWidget.colorTwo;
  }

  /// [updateShouldNotify] 와 기능은 같지만, 각 위젯별로 조건문을 줄 수 있음
  @override
  bool updateShouldNotifyDependent(
      covariant AncestorWidget oldWidget, Set<String> dependencies) {
    if (dependencies.contains('one') && oldWidget.colorOne != colorOne) {
      return true;
    }

    if (dependencies.contains('two') && oldWidget.colorTwo != colorTwo) {
      return true;
    }

    return false;
  }
}

/// 상단 위젯
class DependentWidgetOne extends StatelessWidget {
  const DependentWidgetOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ancestor = AncestorWidget.of(context, 'one');

    return Container(
      color: ancestor.colorOne,
      height: 150,
      width: 200,
      child: const Center(
        child: Text(
          'Dependent Child 1',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}

/// 하단 위젯
class DependentWidgetTwo extends StatelessWidget {
  const DependentWidgetTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ancestor = AncestorWidget.of(context, 'two');

    return Container(
      color: ancestor.colorTwo,
      height: 150,
      width: 200,
      child: const Center(
        child: Text(
          'Dependent Child 2',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
