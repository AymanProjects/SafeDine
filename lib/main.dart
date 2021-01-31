import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppStyleConfiguration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
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
