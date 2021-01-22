import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class SafeDineSnackBar {
  SafeDineSnackBar.error({BuildContext context, String msg}) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: FlashStyle.floating,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FlashBar(
            message: Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            shouldIconPulse: false,
          ),
        );
      },
    );
  }

  SafeDineSnackBar.warning({BuildContext context, String msg}) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: FlashStyle.floating,
          backgroundColor: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FlashBar(
            message: Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            shouldIconPulse: false,
          ),
        );
      },
    );
  }

  SafeDineSnackBar.success({BuildContext context, String msg}) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: FlashStyle.floating,
          backgroundColor: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: FlashBar(
            message: Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            shouldIconPulse: false,
          ),
        );
      },
    );
  }
}
