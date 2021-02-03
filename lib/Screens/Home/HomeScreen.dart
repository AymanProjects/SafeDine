import 'package:SafeDine/Screens/Cart/CartScreen.dart';
import 'package:SafeDine/Screens/Home/widgets/SafeDineBottomNavigation.dart';
import 'package:SafeDine/Screens/Menu/MenuScreen.dart';
import 'package:SafeDine/Screens/Home/widgets/SafeDineDrawer.dart';
import 'package:SafeDine/Screens/OrderProgress/OrderProgressScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/ScreenIndex.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [OrderProgressScreen(), MenuScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeDrawerState>(
          create: (context) => HomeDrawerState(),
        ),
        ChangeNotifierProvider<ScreenIndex>(
          create: (context) => ScreenIndex(),
        ),
      ],
      child: Builder(
          builder: (context) => Consumer<ScreenIndex>(
                builder: (context, screenIndex, _) => Scaffold(
                  drawerEdgeDragWidth: 30,
                  key: Provider.of<HomeDrawerState>(context, listen: false).key,
                  drawerScrimColor: Colors.black12,
                  drawer: SafeDineDrawer(),
                  body: Overlay(
                    initialEntries: [
                      OverlayEntry(builder: (overlayContext) {
                        return screens[screenIndex.index];
                      }),
                    ],
                  ),
                  bottomNavigationBar: SafeDineBottomNavigation(),
                ),
              )),
    );
  }
}

class HomeDrawerState {
  final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
}
