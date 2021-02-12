import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ScreenIndex.dart';

class SafeDineBottomNavigation extends StatefulWidget {
  @override
  _SafeDineBottomNavigationState createState() =>
      _SafeDineBottomNavigationState();
}

class _SafeDineBottomNavigationState extends State<SafeDineBottomNavigation> {
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
              index: 0, icon: Icons.hourglass_empty, context: context),
          bottomBarItem(
              index: 1, icon: CupertinoIcons.doc_plaintext, context: context),
          bottomBarItem(index: 2, icon: CupertinoIcons.cart, context: context),
        ],
      ),
    );
  }

  Widget bottomBarItem({int index, context, IconData icon}) {
    ScreenIndex selectedScreenIndex =
        Provider.of<ScreenIndex>(context, listen: false);
    bool isSelected = (selectedScreenIndex.index == index);
    return Align(
      alignment: isSelected ? Alignment.topCenter : Alignment.center,
      child: Padding(
        padding: isSelected ? EdgeInsets.only(top: 5) : EdgeInsets.zero,
        child: FlatButton(
          child: Icon(
            icon,
            size: 23,
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
