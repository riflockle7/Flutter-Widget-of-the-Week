import 'dart:async';

import 'package:flutter/material.dart';

/// [StreamBuilder]
///
/// 비동기식 데이터 스트림을 사용할 수 있는 위젯
/// 스트림에서 나오는 이벤트를 따름
/// 새로운 이벤트가 나올때마다 배출하여 최신 데이터를 유지
///
/// 과정
/// 1. StreamBuilder 에 stream 연결
/// 2. 그 다음 builder 를 작성
/// 3. 빈화면에 대한 처리
///    1. snapShot.hasData 를 통해 데이터 있는지 확인하고 이에 따라 로직 처리
///       (더 세분화하려면 ConnectionState 확인하기)
///    2. initialData 를 활용한 처리
/// snapShot.hasError 를 통해 에러 확인도 가능
///
/// ex1. 0~9 까지 emit 하는 시나리오
///   AsyncSnapshot<int>.withData([ConnectionState.waiting], null)
///   AsyncSnapshot<int>.withData(ConnectionState.active, 0)
///   AsyncSnapshot<int>.withData(ConnectionState.active, 1)
///   ...
///   AsyncSnapshot<int>.withData(ConnectionState.active, 9)
///   AsyncSnapshot<int>.withData([ConnectionState.done], 9)
///
/// ex2.이벤트 생성 중에 StreamBuilder 구성을 다른 스트림으로 변경시 시나리오
///   AsyncSnapshot<int>.withData(ConnectionState.none, 5)    // 전자는 이전 스트림이 null 이 아닌 경우에만 생성됨
///   AsyncSnapshot<int>.withData(ConnectionState.waiting, 5) // 후자는 새 스트림이 null 이 아닌 경우에만 생성됨
///
/// ex3. 스트림 오류 생성 시나리오
///   AsyncSnapshot<int>.withError(ConnectionState.active, 'some error', someStackTrace)  // 상태가 [ConnectionState.active] 일 때만 변경됨
///
/// 초기 스냅샷 데이터는 initialData를 지정하여 제어
///
/// @see [https://youtu.be/MkKEWHfy99Y]
/// @see [https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html]
/// @see [https://devmg.tistory.com/183]
///
/// [ConnectionState.done] 이 나오는 케이스는 잘 모르겠다. (아래 케이스는 ex1 케이스와 비슷)
/// 데이터가 변하는 걸 보고 적절히 처리하는 리스너 같은 느낌
/// 음악 재생, 기타 스트림 과정이 필요할 때는 요긴하게 쓰일 듯함
///
class StreamBuilderScreen extends StatelessWidget {
  const StreamBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder'),
      ),
      body: const StreamBuilderWidget(),
    );
  }
}

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({Key? key}) : super(key: key);

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final Stream<int> _bids = (() {
    late final StreamController<int> controller;
    controller = StreamController<int>(
      onListen: () async {
        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(1);

        // 에러 발생 시 해당 로직 아래의 남은 stream 은 실행되지 않음
        // await Future<void>.delayed(const Duration(seconds: 1));
        // controller.addError(Object(), StackTrace.empty);

        await Future<void>.delayed(const Duration(seconds: 1));
        controller.add(2);
        await Future<void>.delayed(const Duration(seconds: 1));
        await controller.close();
      },
    );
    return controller.stream;
  })();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: StreamBuilder<int>(
        stream: _bids,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;
          // 에러 발생 시
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Stack trace: ${snapshot.stackTrace}'),
              ),
            ];
          } else {
            switch (snapshot.connectionState) {
              // 연결 안됨(?)
              case ConnectionState.none:
                children = const <Widget>[
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Select a lot'),
                  )
                ];
                break;
              // 기다리는 중
              case ConnectionState.waiting:
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting bids...'),
                  )
                ];
                break;
              // 활성화된 상태
              case ConnectionState.active:
                children = <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('\$${snapshot.data}'),
                  )
                ];
                break;
              // 완료 상태
              case ConnectionState.done:
                children = <Widget>[
                  const Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('\$${snapshot.data} (closed)'),
                  )
                ];
                break;
            }
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
        },
      ),
    );
  }
}
