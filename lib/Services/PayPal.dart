import 'dart:async';
import 'package:SafeDine/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPal {
  static final String _url =
      'https://us-central1-safedine-66679.cloudfunctions.net/app/pay';

  static Future<void> pay(BuildContext context, Order order) {
    final completer = Completer<void>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SafeArea(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl:
                Uri.dataFromString(htmlPost(order), mimeType: 'text/html')
                    .toString(),
            onPageFinished: (url) {
              if (url.contains('complete')) {
                Navigator.of(context).pop('success');
              } else if (url.contains('cancel')) {
                Navigator.of(context).pop('paymentCancelled');
              }
            },
          ),
        ),
      ),
    ).then((dynamic result) {
      //on webview closed
      if (result == 'success')
        completer.complete();
      else
        completer.completeError(PlatformException(code: 'paymentCancelled'));
    });

    return completer.future;
  }

  static String htmlPost(Order order) {
    return '''
      <html>

      <body onload="document.form.submit();">

      <form id="form" name="form" method="POST" action="$_url">

      <input type="hidden" name="price" value="${(order.getTotalPrice()/3.75).toStringAsFixed(2)}"/>
      </from>

      </body>

      </html>
    ''';
  }
}
