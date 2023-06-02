import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration? decoration;

  const CustomText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 16.0,
      this.decoration = TextDecoration.none,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: decoration),
    );
  }
}
