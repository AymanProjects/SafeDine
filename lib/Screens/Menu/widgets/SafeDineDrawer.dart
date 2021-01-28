import 'dart:ui';
import 'package:SafeDine/Screens/Authentication/AuthScreen.dart';
import 'package:SafeDine/Services/Authentication.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/AppLogo.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SafeDineDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 55.h),
                AppLogo(
                  size: 90,
                  color: Provider.of<AppTheme>(context, listen: false).primary,
                ),
                SizedBox(
                  height: 30.h,
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.time),
                  title: Text('Order history'),
                  onTap: () {

                  },
                ),
                // Divider(
                //   thickness: 1,
                //   height: 2,
                // ),
              ],
            ),
            Column(
              children: [
                logoutWidget(context),
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

  Widget loginWidget(context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Login'),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AuthScreen(),
            ));
      },
    );
  }

  Widget logoutWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SafeDineButton(
        color: Colors.redAccent,
        fontSize: 14,
        text: 'Logout',
        function: () {
          Provider.of<Authentication>(context, listen: false).signOut();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
