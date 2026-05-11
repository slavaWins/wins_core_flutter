import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class Text1 extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final Color? color;

  const Text1(this.text, {Key? key, this.overflow, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppStyle().body1(color: color), overflow: overflow);
  }
}
