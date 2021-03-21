import 'dart:ui';
import 'package:SafeDine/Models/Branch.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Providers/TableNumber.dart';
import 'package:SafeDine/Screens/Authentication/AuthScreen.dart';
import 'package:SafeDine/Screens/Home/widgets/DrawerTile.dart';
import 'package:SafeDine/Screens/OrderHistory/OrderHistoryScreen.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/AppLogo.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:SafeDine/Services/FlashSnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SafeDineDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Branch branch = Provider.of<Branch>(context, listen: false);
    TableNumber tableNumber = Provider.of<TableNumber>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Stack(children: [
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 19.0,
              sigmaY: 19.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 55),
                AppLogo(
                  size: 90,
                  color: Provider.of<AppTheme>(context, listen: false).primary,
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerTile(
                  text: 'Order history',
                  icon: CupertinoIcons.time,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderHistory()),
                    );
                  },
                ),
                DrawerTile(
                  text: 'Call waiter',
                  icon: Icons.notifications_outlined,
                  onTap: () async {
                    try {
                      await Visitor().callWaiter(branch.getID(),
                          'Help needed at table ' + tableNumber.number + '!');
                      Navigator.of(context).pop();
                      FlashSnackBar.success(
                        message: 'Your request was sent to the waiter',
                      );
                    } on PlatformException catch (exception) {
                      FlashSnackBar.error(
                        message: 'Couldn\'t send your request',
                      );
                    }
                  },
                ),
              ],
            ),
            Column(
              children: [
                authBotton(context),
                SizedBox(
                  height: 10,
                ),
                Text('Version 1.0.0'),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Widget authBotton(context) {
    Visitor visitor = Provider.of<Visitor>(context, listen: false);

    return visitor.getID() != null
        ? logoutButton(context)
        : loginButton(context);
  }

  Widget loginButton(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SafeDineButton(
        key: ValueKey('drawer login button'),
        color: Colors.green,
        fontSize: 14,
        text: 'Login',
        function: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AuthScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget logoutButton(context) {
    Visitor visitor = Provider.of<Visitor>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SafeDineButton(
        key: ValueKey('drawer logout button'),
        color: Colors.redAccent,
        fontSize: 14,
        text: 'Logout',
        function: () {
          visitor.logout();
          Navigator.of(context).pop();
          FlashSnackBar.warning(message: 'Logged out');
        },
      ),
    );
  }
}
