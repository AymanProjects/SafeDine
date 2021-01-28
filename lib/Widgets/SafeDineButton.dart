import 'package:flutter/material.dart';

class SafeDineButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Function function;
  final bool loading;
  final Color color;
  SafeDineButton({this.loading = false, this.text = '', this.function, @required this.fontSize,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: color == null ? Theme.of(context).primaryColor :
          color,
          disabledColor: Theme.of(context).primaryColor.withOpacity(0.3),
          onPressed: loading ? null : function, //null to disable button
          child: Padding(
              padding: EdgeInsets.all(12),
              child: loading
                  ? Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    )
                  : Text(
                      text,
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
    );
  }
}
