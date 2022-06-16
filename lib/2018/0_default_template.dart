import 'package:flutter/material.dart';

/// [제목]
///
/// [명세]
///
/// @see [youtube_link]
/// @see [define_link]
/// @see [other_link]
///
/// [느낀점]
///
class DefaultTemplateScreen extends StatelessWidget {
  const DefaultTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('[제목]'),
      ),
      body: const Text(""),
    );
  }
}
