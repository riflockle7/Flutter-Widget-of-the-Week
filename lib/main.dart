import 'package:flutter/material.dart';

import '2018/1_safeArea.dart';
import '2018/2_expanded.dart';
import '2018/3_wrap.dart';
import '2018/4_animated_container.dart';
import '2018/5_opacity.dart';
import '2018/6_future_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SafeAreaScreen(),
                    ),
                  );
                },
                child: const Text("SafeArea")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpandedScreen(),
                    ),
                  );
                },
                child: const Text("Expanded")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WrapScreen(),
                    ),
                  );
                },
                child: const Text("Wrap")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnimatedContainerScreen(),
                    ),
                  );
                },
                child: const Text("AnimatedContainer")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OpacityScreen(),
                    ),
                  );
                },
                child: const Text("Opacity")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FutureBuilderScreen(),
                    ),
                  );
                },
                child: const Text("FutureBuilder")),
          ],
        ),
      ),
    );
  }
}
