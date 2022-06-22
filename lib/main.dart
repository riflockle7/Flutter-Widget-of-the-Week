import 'package:flutter/material.dart';
import 'package:widget_of_the_week/2018/0012_sliver_list_grid.dart';

import '2018/0001_safeArea.dart';
import '2018/0002_expanded.dart';
import '2018/0003_wrap.dart';
import '2018/0004_animated_container.dart';
import '2018/0005_opacity.dart';
import '2018/0006_future_builder.dart';
import '2018/0007_fade_transition.dart';
import '2018/0008_floating_action_button.dart';
import '2018/0009_page_view.dart';
import '2018/0010_table.dart';
import '2018/0011_silver_app_bar.dart';
import '2018/0013_fade_in_image.dart';
import '2018/0014_stream_builder.dart';
import '2018/0015_inherited_model.dart';
import '2018/0016_clip_r_rect.dart';
import '2018/0017_hero.dart';
import '2018/0018_custom_paint.dart';
import '2018/0019_tool_tip.dart';
import '2019/0020_fitted_box.dart';
import '2019/0021_layout_builder.dart';
import '2019/0022_absorb_pointer.dart';
import '2019/0023_transform.dart';

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
        child: ListView(
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
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FadeTransitionScreen(),
                    ),
                  );
                },
                child: const Text("FadeTransition")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FloatingActionButtonScreen(),
                    ),
                  );
                },
                child: const Text("FloatingActionButton")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageViewScreen(),
                    ),
                  );
                },
                child: const Text("PageView")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TableScreen(),
                    ),
                  );
                },
                child: const Text("Table")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SliverAppBarScreen(),
                    ),
                  );
                },
                child: const Text("SliverAppBar")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SliverListGridScreen(),
                    ),
                  );
                },
                child: const Text("SliverListGrid")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FadeInImageScreen(),
                    ),
                  );
                },
                child: const Text("FadeInImage")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StreamBuilderScreen(),
                    ),
                  );
                },
                child: const Text("StreamBuilder")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InheritModelScreen(),
                    ),
                  );
                },
                child: const Text("InheritModel")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClipRRectScreen(),
                    ),
                  );
                },
                child: const Text("ClipRRect")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HeroScreen(),
                    ),
                  );
                },
                child: const Text("Hero")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomPaintScreen(),
                    ),
                  );
                },
                child: const Text("CustomPaint")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TooltipScreen(),
                    ),
                  );
                },
                child: const Text("Tooltip")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FittedBoxScreen(),
                    ),
                  );
                },
                child: const Text("FittedBox")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LayoutBuilderScreen(),
                    ),
                  );
                },
                child: const Text("LayoutBuilder")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AbsorbPointerScreen(),
                    ),
                  );
                },
                child: const Text("AbsorbPointer")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransformScreen(),
                    ),
                  );
                },
                child: const Text("Transform")),
          ],
        ),
      ),
    );
  }
}
