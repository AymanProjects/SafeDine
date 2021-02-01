import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Utilities/Validations.dart';
import 'package:SafeDine/Widgets/SafeDineField.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SnackbarType {
  Error,
  Warning,
  Success,
  CartNotification,
}

class SafeDineSnackBar {
  static FlashController _previousController;

  static void showConfirmationDialog({
    @required BuildContext context,
    @required String message,
    @required Widget negativeActionText,
    @required Function negativeAction,
    @required Widget positiveActionText,
    @required Function positiveAction,
  }) {
    showFlash(
      transitionDuration: Duration(milliseconds: 200),
      context: context,
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
                    fontSize: 16,
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
                            child: negativeActionText),
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

  static void showNotification(
      {@required SnackbarType type,
      @required BuildContext context,
      @required String msg,
      Function ontap,
      String actionName = 'Dismiss',
      Function onActionTap,
      int duration = 3}) {
    Color color;
    IconData icon;
    bool dismissOnClick = false;
    if (type == SnackbarType.Error) {
      color = Colors.red;
      icon = Icons.error_outline;
    } else if (type == SnackbarType.Warning) {
      color = Colors.orange;
      icon = Icons.info_outline;
    } else if (type == SnackbarType.Success) {
      color = Colors.green;
      icon = Icons.done;
    } else if (type == SnackbarType.CartNotification) {
      color = Provider.of<AppTheme>(context, listen: false).primary;
      icon = CupertinoIcons.cart;
      dismissOnClick = true;
    }
    _snackBar(
      context: context,
      duration: duration,
      msg: msg,
      ontap: () {
        if (ontap != null) ontap();
        if (_previousController?.isDisposed == false && dismissOnClick)
          _previousController.dismiss();
      },
      actionName: actionName,
      onActionTap: () {
        if (onActionTap != null) onActionTap();
      },
      icon: icon,
      color: color,
    );
  }

  static void _snackBar(
      {BuildContext context,
      String msg,
      Color color,
      String actionName,
      Function onActionTap,
      int duration,
      IconData icon,
      Function ontap}) {
    if (_previousController?.isDisposed == false) _previousController.dismiss();
    _previousController = FlashController(context, (context, controller) {
      return Flash(
        controller: controller,
        onTap: ontap,
        style: FlashStyle.floating,
        backgroundColor: color,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: FlashBar(
          padding: EdgeInsets.symmetric(vertical: 13),
          primaryAction: InkWell(
            onTap: () {
              if (_previousController?.isDisposed == false)
                _previousController.dismiss();
              onActionTap();
            },
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(right: 10),
              child: Center(
                  child: Text(actionName,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.45),
                          fontWeight: FontWeight.bold))),
            ),
          ),
          message: Text(
            msg,
            style: TextStyle(color: Colors.white),
          ),
          icon: Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          shouldIconPulse: false,
        ),
      );
    },
        duration: Duration(seconds: duration),
        persistent: false,
        transitionDuration: Duration(milliseconds: 400));
    _previousController.show();
  }

  //
  static void showTextFieldDialog({
    @required BuildContext context,
    @required String message,
    @required Widget positiveActionText,
    @required Function positiveAction,
    @required Widget negativeActionText,
    @required Function negativeAction,
  }) {
    String textFieldValue = '';
    final _formKey = GlobalKey<FormState>();
    bool _loading = false;
    showFlash(
      transitionDuration: Duration(milliseconds: 200),
      context: context,
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
                title: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                message: Form(
                  key: _formKey,
                  child: SafeDineField(
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
                              if (controller?.isDisposed == false)
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              controller.dismiss();
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
                                      await positiveAction(
                                          textFieldValue, controller);
                                      setState(() {
                                        _loading = false;
                                      });
                                    }
                                  }
                                },
                                child: positiveActionText),
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
