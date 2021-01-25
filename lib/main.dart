import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppStyleConfiguration.dart';
import 'Screens/Authentication/AuthScreen.dart';
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
      ],
      child: AppStyleConfiguration(
        child: HomeScreen(),
      ),
    ),
  );
}
