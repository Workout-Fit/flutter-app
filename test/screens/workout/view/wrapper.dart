import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Flex(direction: Axis.vertical, children: <Widget>[child]),
      ),
    );
  }
}
