import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:SafeDine/Screens/QR/QRScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'AppStyleConfiguration.dart';
import 'Services/Authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/svg_images/scan.svg',
    ),
    null,
  );
  await precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoder,
      'assets/svg_images/SafeDine.svg',
    ),
    null,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
        Provider<Visitor>(
          create: (context) => Visitor(),
        ),
      ],
      child: AppStyleConfiguration(
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Visitor visitor = Provider.of(context, listen: false);
    return StreamBuilder<FirebaseUser>(
        stream: Authentication.getUserState(),
        builder: (context, snapshot) {
          print('object');
          if (snapshot.hasData) {
            visitor.setID(snapshot.data.uid);
          } else
            visitor.setID(null);
          return QRScreen();
        });
  }
}
