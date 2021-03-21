import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Utilities/Validations.dart';
import 'package:SafeDine/Widgets/SafeDineField.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashSnackBar {
  static FlashController _previousController;
  static BuildContext _context;
  FlashSnackBar._();

  static void init(BuildContext context) {
    _context = context;
  }

  static void error(
      {@required String message, String actionName, Function onActionTap}) {
    _showSnackBar(
      msg: message,
      color: Colors.red,
      icon: Icons.error_outline,
      actionName: actionName,
      onActionTap: onActionTap,
    );
  }

  static void warning({@required String message}) {
    _showSnackBar(
      msg: message,
      color: Colors.orange,
      icon: Icons.info_outline,
    );
  }

  static void success(
      {@required String message, Function onTap, int duration}) {
    _showSnackBar(
      msg: message,
      color: Colors.green,
      icon: Icons.done,
      onTap: onTap,
      duration: duration,
    );
  }

  static void _showSnackBar({
    String msg,
    @required Color color,
    int duration,
    IconData icon,
    Function onTap,
    String actionName,
    Function onActionTap,
  }) {
    if (_previousController?.isDisposed == false) _previousController.dismiss();
    _previousController = FlashController(_context, (context, controller) {
      return Flash(
        controller: controller,
        onTap: () {
          if (onTap != null) {
            onTap();
            if (_previousController?.isDisposed == false)
              _previousController.dismiss();
          }
        },
        backgroundColor: color,
        child: FlashBar(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          message: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 16),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (_previousController?.isDisposed == false)
                    _previousController.dismiss();

                  onActionTap?.call();
                },
                child: Text(
                  actionName ?? 'Dismiss',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.45),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
        duration: Duration(seconds: duration ?? 4),
        persistent: false,
        transitionDuration: Duration(milliseconds: 400));
    _previousController.show();
  }

  static void showTextFieldDialog({
    @required String initialData,
    @required String message,
    @required Widget positiveActionText,
    @required Future Function(String) positiveAction,
    @required Widget negativeActionText,
    @required Function negativeAction,
    Key key,
  }) {
    String textFieldValue = initialData;
    final _formKey = GlobalKey<FormState>();
    bool _loading = false;
    showFlash(
      transitionDuration: Duration(milliseconds: 200),
      context: _context,
      persistent: false,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Flash.dialog(
              backgroundColor: Provider.of<AppTheme>(_context).darkWhite,
              enableDrag: true,
              controller: controller,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: FlashBar(
                shouldIconPulse: false,
                title: Text(
                  message,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                message: Form(
                  key: _formKey,
                  child: SafeDineField(
                    key: key,
                    initialValue: initialData,
                    validator: (val) => Validations.emailValidation(val),
                    hintText: 'Email',
                    icon: Icon(Icons.email),
                    onChanged: (value) {
                      textFieldValue = value;
                    },
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (negativeAction != null) negativeAction();
                              if (controller?.isDisposed == false) {
                                controller.dismiss();
                              }
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: negativeActionText),
                        SizedBox(
                          width: 25,
                        ),
                        _loading
                            ? Container(
                                margin: EdgeInsets.only(right: 5),
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ))
                            : InkWell(
                                onTap: () async {
                                  if (positiveAction != null) {
                                    if (_formKey.currentState.validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      setState(() {
                                        _loading = true;
                                      });
                                      await positiveAction(textFieldValue)
                                          .then((value) {
                                        if (controller?.isDisposed == false) {
                                          controller.dismiss();
                                        }
                                      });
                                      setState(() {
                                        _loading = false;
                                      });
                                    }
                                  }
                                },
                                child: positiveActionText,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void showConfirmationDialog({
    @required String message,
    @required Widget negativeActionText,
    @required Function negativeAction,
    @required Widget positiveActionText,
    @required Function positiveAction,
  }) {
    showFlash(
      transitionDuration: Duration(milliseconds: 200),
      context: _context,
      persistent: false,
      builder: (context, controller) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Flash.dialog(
              enableDrag: true,
              controller: controller,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: FlashBar(
                shouldIconPulse: false,
                message: Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (positiveAction != null) positiveAction();
                              if (controller?.isDisposed == false)
                                controller.dismiss();
                            },
                            child: positiveActionText),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            if (negativeAction != null) negativeAction();
                            if (controller?.isDisposed == false)
                              controller.dismiss();
                          },
                          child: negativeActionText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
