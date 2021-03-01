import 'dart:convert';
import 'package:SafeDine/Models/Branch.dart';
import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Providers/TableNumber.dart';
import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:SafeDine/Services/FirebaseException.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/FadeRouteAnimation.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:SafeDine/Services/FlashSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  bool _loading = false;

  @override
  void setState(func) {
    if (mounted) {
      super.setState(func);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Container(
            height: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_images/scan.svg',
                      height: 160,
                      semanticsLabel: 'Logo',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Start by clicking the button and scan the QR code found in restaurant to download food menu.',
                      style: TextStyle(
                          color: Provider.of<AppTheme>(context, listen: false)
                              .grey,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ],
                ),
                SafeDineButton(
                  text: 'Scan QR Code',
                  function: () => _buttonPress(context),
                  loading: _loading,
                  //   fontSize: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buttonPress(context) async {
    setState(() {
      _loading = true;
    });
    dynamic decodedResult = {
      'branchID': 'ZeVwvgGUg2mqF9yeW4sh', //MNk7koNiG36Vhaxk8KOG
      'tableNumber': '8'
    };
    try {
      // String result = await Visitor().scanQR();
      // if (result == null) throw FormatException();
      // if (result.isEmpty) throw PlatformException(code: 'cancelled');

      // decodedResult = jsonDecode(result);
      // if (!(decodedResult is Map<dynamic, dynamic>)) throw FormatException();

      Branch branch = await Branch().fetch(decodedResult['branchID']);
      Restaurant restaurant =
          await Restaurant().fetch(branch.getRestaurantID());

      Navigator.push(
        context,
        FadeRouteAnimation(
          page: MultiProvider(
            providers: [
              Provider<Branch>.value(
                value: branch,
              ),
              Provider<Restaurant>.value(
                value: restaurant,
              ),
              Provider<TableNumber>(
                create: (context) => TableNumber(decodedResult['tableNumber']),
              ),
            ],
            child:
                WillPopScope(onWillPop: () async => false, child: HomeScreen()),
          ),
        ),
      );
    } on PlatformException catch (exception) {
      String msg;
      if (exception.code == 'cancelled')
        msg = 'Incomplete scan, please try again';
      else
        msg = FirebaseException.generateReadableMessage(exception);
      FlashSnackBar.error(message: msg);
    } on FormatException catch (e) {
      FlashSnackBar.warning(message: 'QR code is invalid');
    }

    setState(() {
      _loading = false;
    });
  }
}
