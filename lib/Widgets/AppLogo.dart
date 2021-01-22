import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  AppLogo({this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.circle,
      color: Theme.of(context).primaryColor,
      size: size,
    );
  }
}
