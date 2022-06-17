import 'dart:math';

import 'package:flutter/material.dart';

/// [FutureBuilder]
///
/// Future 상호작용에 대한 응답값을 기반으로 위젯을 만들어야하는 경우 활용할 수 있는 클래스
///
/// [State.build] 전 생명주기에서, Future 를 얻어오는 걸 추천
/// ex. [State.initState], [State.didUpdateWidget] 또는 [State.didChangeDependencies]
///
/// FutureBuilder 생성 시, [State.build] 호출 중에 생성하면 안됨 ([StatelessWidget], [StateFulWidget] 모두 동일)
/// Future 가 FutureBuilder 와 동시에 생성 시, FutureBuilder 의 부모가 다시 build 될 때마다 비동기 작업이 다시 시작됨
/// builder 콜백은 flutter 파이프라인 재량에 따라 호출됨 ( = 정확한 시점을 알기 어려움)
///
/// [FutureBuilder]에 새롭지만 이미 완료된 미래를 제공하면 [ConnectionState.waiting] 상태의 단일 프레임이 생성됨 (???)
/// [Future]가 이미 완료되었음을 동기적으로 확인할 수 있는 방법은 없음 (TODO await 는?)
///
/// 데이터를 성공적으로 받아오는 경우, initialData 가 null 이라 가정하면
/// 빌더는 다음 중 후자 또는 둘다를 사용하여 호출됨
/// 1. AsyncSnapshot<String>.withData(ConnectionState.waiting, null) - 기다리는 중
/// 2. AsyncSnapshot<String>.withData(ConnectionState.done, 'some data') - 성공
///
/// 에러 발생시 다음 중 후자 또는 둘 다 사용하여 호출됨
/// 1. AsyncSnapshot<String>.withData(ConnectionState.waiting, null) - 기다리는 중
/// 2. AsyncSnapshot<String>.withError(ConnectionState.done, 'some error', someStackTrace) - 실패
///
/// 초기 스냅샷 데이터는 initialData 를 지정하여 제어할 수 있음
/// 이 기능을 활용해 Future 전 빌더가 호출되는 경우, initialData 를 활용하도록 함
///
/// 스냅샷 데이터 및 오류 필드는 연결 상태가 대기에서 완료로 전환될 때만 변경됨
/// [FutureBuilder] 구성을 다른 Future 로 변경할 때 유지됨
/// 이전 Future 가 성공적으로 완료된 경우 구성을 새 Future 로 변경하면 아래 두 개가 생성됨
/// 1. AsyncSnapshot<String>.withData(ConnectionState.none, 'data of first future')
/// 2. AsyncSnapshot<String>.withData(ConnectionState.waiting, 'data of second future')
/// 일반적으로 후자는 새로운 [Future] 가 null 이 아닌 경우에만 생성되고, 전자는 오래된 [Future] 가 [null] 이 아닌 경우에만 생성됨
///
/// Flutter 와 Dart 단순 로직 작업으로는 동기화가 되지 않음
/// Dart 의 [Future] 개념을 활용하면 동기 활용 가능
/// (서버에서 데이터를 모두 받아오기전 화면을 그려줄수 있게 되는 장점을 가질수 있음)
///
/// connectionState 로 Future 의 상태를 확실히 확인하는 작업 필요
///
/// @see [https://youtu.be/ek8ZPdWj4Qo]
/// @see [https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html]
/// @see [https://eory96study.tistory.com/21]
///
class FutureBuilderScreen extends StatelessWidget {
  const FutureBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder'),
      ),
      body: const FutureBuilderWidget(),
    );
  }
}

class FutureBuilderWidget extends StatefulWidget {
  const FutureBuilderWidget({Key? key}) : super(key: key);

  @override
  State<FutureBuilderWidget> createState() => _FutureBuilderWidgetState();
}

class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  // 1초 딜레이 후 특정 값을 얻는 Future<String>
  final Future<String> _calculation_1_sec = Future<String>.delayed(
    const Duration(seconds: 1),
    () {
      if (Random().nextBool()) throw Exception();
      return 'Data Loaded';
    },
  );

  // 2초 딜레이 후 특정 값을 얻는 Future<String>
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () {
      if (Random().nextBool()) throw Exception();
      return 'Data Loaded';
    },
  );

  // 바닐라 패턴에서 사용할 state 값
  var value = "";
  var errorStatus = "none";

  @override
  void initState() {
    super.initState();
    if (Random().nextBool()) {
      usePromiseLogic();
    } else {
      useAsyncLogic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: useVanillaBuilder()),
        const SizedBox(height: 50),
        Center(child: useFutureBuilder())
      ],
    );
  }

  Widget useVanillaBuilder() {
    if (errorStatus == "success") {
      return getBodyWidget(getSuccessWidget(value));
    } else if (errorStatus == "error") {
      return getBodyWidget(getErrorWidget(value));
    } else {
      return getBodyWidget(getLoadingWidget('Vanilla'));
    }
  }

  void usePromiseLogic() {
    String value = "";
    _calculation_1_sec.then((result) {
      value = 'promise Result: $result';
      print(value);
      setState(() {
        errorStatus = "success";
        this.value = value;
      });
    }).catchError((error) {
      value = 'promise Error: ${error.toString()}';
      print(value);
      setState(() {
        errorStatus = "error";
        this.value = value;
      });
    });
  }

  Future<void> useAsyncLogic() async {
    String value = "";
    String errorStatus = "error";
    try {
      errorStatus = "success";
      value = 'async Result: ${await _calculation_1_sec}';
    } catch (error) {
      errorStatus = "error";
      value = 'async Error: ${error.toString()}';
    }

    print(value);
    setState(() {
      this.errorStatus = errorStatus;
      this.value = value;
    });
  }

  Widget useFutureBuilder() {
    return FutureBuilder<String>(
      future: _calculation, // 이전에 얻은 Future<String> 또는 null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;

        // snapshot 에 데이터가 있을 경우
        if (snapshot.hasData) {
          children = getSuccessWidget('FutureBuilder Result: ${snapshot.data}');
        }

        // snapshot 에 에러가 있을 경우
        else if (snapshot.hasError) {
          children = getErrorWidget('FutureBuilder Error: ${snapshot.error}');
        }

        // 그 이외의 경우 (기다리는 상태 등)
        else {
          children = getLoadingWidget('FutureBuilder');
        }

        return getBodyWidget(children);
      },
    );
  }

  Widget getBodyWidget(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  List<Widget> getSuccessWidget(String message) {
    return <Widget>[
      const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(message),
      )
    ];
  }
}

List<Widget> getErrorWidget(String message) {
  return <Widget>[
    const Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 60,
    ),
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(message),
    )
  ];
}

List<Widget> getLoadingWidget(String type) {
  return <Widget>[
    const SizedBox(
      width: 60,
      height: 60,
      child: CircularProgressIndicator(),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text('$type Awaiting result...'),
    )
  ];
}
