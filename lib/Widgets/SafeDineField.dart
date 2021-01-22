import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SafeDineField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onChanged;
  final bool autoValidate;
  final bool isPassword;
  final bool isEmail;
  final Icon icon;
  final bool enabled;
  SafeDineField(
      {this.enabled = true,
      this.autoValidate = false,
      this.hintText,
      this.validator,
      this.onChanged,
      this.isPassword = false,
      this.isEmail = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: TextStyle(fontSize: 16, ),
      decoration: InputDecoration(
        hintText: hintText,
        errorMaxLines: 1,
        hintMaxLines: 1,
        suffixIcon: icon,
        contentPadding: EdgeInsets.all(16.0),
        filled: true,
        fillColor: Provider.of<AppTheme>(context).darkWhite,

        enabledBorder: border(context:context),
        focusedBorder: border(context: context, isSelected: true),
        errorBorder: border(context:context),
        disabledBorder: border(context:context),
        focusedErrorBorder: border(context: context, isSelected: true),
      ),
      cursorColor: Theme.of(context).primaryColor,
      obscureText: isPassword ? true : false,
      validator: validator,
      autovalidate: autoValidate,
      onChanged: onChanged,
      maxLines: 1,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    );
  }

  OutlineInputBorder border({bool isSelected = false, context}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color:Provider.of<AppTheme>(context).darkWhite,
        width: 0.5,
        style: BorderStyle.solid,
      ),
    );
  }
}
