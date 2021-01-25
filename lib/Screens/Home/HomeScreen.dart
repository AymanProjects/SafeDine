import 'package:SafeDine/Screens/Cart/CartScreen.dart';
import 'package:SafeDine/Screens/Menu/MenuScreen.dart';
import 'package:SafeDine/Screens/OrderProgress/OrderProgressScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/EpicBottomNavigation.dart';
import 'widgets/ScreenIndex.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [OrderProgressScreen(), MenuScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScreenIndex>(
        create: (context) => ScreenIndex(),
        child: Builder(
          builder: (context) => Consumer<ScreenIndex>(
            builder: (context, screenIndex, _) => 
            
            Stack(
              children: [
                Overlay(
                  initialEntries: [
                    OverlayEntry(builder: (overlayContext) {
                      return screens[screenIndex.index];
                    }),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: EpicBottomNavigation()),
              ],
            ),
          ),
        ));
  }
}
