import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'ScreenIndex.dart';

class EpicBottomNavigation extends StatefulWidget {

  @override
  _EpicBottomNavigationState createState() => _EpicBottomNavigationState();
}

class _EpicBottomNavigationState extends State<EpicBottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Provider.of<AppTheme>(context, listen: false).white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          bottomBarItem(
              index: 0,
              size: 25.h,
              icon: Icons.hourglass_empty,
              context: context),
          bottomBarItem(
              index: 1,
              size: 25.h,
              icon: CupertinoIcons.doc_plaintext,
              context: context),
          bottomBarItem(
              index: 2,
              size: 25.h,
              icon: CupertinoIcons.cart,
              context: context),
        ],
      ),
    );
  }

  Widget bottomBarItem({int index, context, IconData icon, double size}) {
    ScreenIndex selectedScreenIndex = Provider.of<ScreenIndex>(context, listen: false);
    bool isSelected = (selectedScreenIndex.index == index);
    return Align(
      alignment: isSelected ? Alignment.topCenter : Alignment.center,
      child: Padding(
        padding: isSelected ? EdgeInsets.only(top: 5.w) : EdgeInsets.zero,
        child: FlatButton(
          child: Icon(
            icon,
            size: size,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Provider.of<AppTheme>(context, listen: false).grey,
          ),
          onPressed: () {
            setState(() {
              selectedScreenIndex.setScreenIndex(index);
            });       
          },
        ),
      ),
    );
  }
}
