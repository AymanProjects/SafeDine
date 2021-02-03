import 'dart:async';
import 'package:SafeDine/Models/Order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPal {
  static final String _url =
      'https://us-central1-safedine-66679.cloudfunctions.net/app/pay';

  static Future<void> pay(BuildContext context, Order order) {
    bool _loading = true;
    final completer = Completer<void>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SafeArea(
          child: StatefulBuilder(
            builder: (context, setState) => Stack(
              children: [
                WebView(
                  onPageStarted: (_) {
                    setState(() => _loading = true);
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebResourceError: (error) {
                    completer.completeError(error);
                    Navigator.of(context).pop('error');
                  },
                  initialUrl:
                      Uri.dataFromString(htmlPost(order), mimeType: 'text/html')
                          .toString(),
                  onPageFinished: (url) {
                    setState(() => _loading = false);
                    if (url.contains('complete')) {
                      completer.complete();
                      Navigator.of(context).pop('success');
                    } else if (url.contains('cancel')) {
                      completer.completeError(
                          PlatformException(code: 'paymentCancelled'));
                      Navigator.of(context).pop('cancelled');
                    }
                  },
                ),
                _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ).then((result) {
      //on back button pressed
      if (result == null)
        completer.completeError(PlatformException(code: 'paymentCancelled'));
    });

    return completer.future;
  }

  static String htmlPost(Order order) {
    return '''
      <html>

      <body onload="document.form.submit();">

      <form id="form" name="form" method="POST" action="$_url">
      
      <input type="hidden" name="price" value="${order.getTotalPrice()}"/>
      </from>

      </body>

      </html>
    ''';
  }
}
