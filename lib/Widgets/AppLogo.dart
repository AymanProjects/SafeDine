import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color color;
  AppLogo({this.size, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Icon(
      Icons.circle,
      color: color,
    ),
    );
  }
}
