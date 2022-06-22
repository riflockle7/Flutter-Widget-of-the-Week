import 'package:flutter/material.dart';

/// [DefaultTemplate]
///
/// [명세]
///
/// @see [youtube_link]
/// @see [https://api.flutter.dev/flutter/widgets/DefaultTemplate-class.html]
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
        title: const Text('DefaultTemplate'),
      ),
      body: const Text(""),
    );
  }
}
