import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppStyleConfiguration.dart';
import 'Services/Authentication.dart';
import 'Services/Database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (context) => Authentication(),
        ),
        Provider<Database>(
          create: (context) => Database(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
      ],
      child: AppStyleConfiguration(
        child: HomeScreen(),
      ),
    ),
  );
}
