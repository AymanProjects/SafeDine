import 'package:SafeDine/Models/Branch.dart';
import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Providers/HomeDrawerState.dart';
import 'package:SafeDine/Screens/Menu/widgets/DrawerIcon.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CategoryTabs.dart';

class MenuAppBar extends StatelessWidget {
  final Restaurant restaurant;

  MenuAppBar({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
          ),
        ],
      ),
      child: AppBar(
        titleSpacing: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Provider.of<AppTheme>(context, listen: false).white,
        title: Text(
          '${restaurant.getName()} - ${Provider.of<Branch>(context,listen:false).getName()}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Provider.of<HomeDrawerState>(context, listen: false)
                    .key
                    .currentState
                    .openDrawer();
              },
              child: DrawerIcon(
                width: 22,
                hieght: 2,
                spaceBetween: 4,
                leftPadding: 15,
                topPadding: 0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(0, 0),
          child: CategoryTabs(restaurant),
        ),
      ),
    );
  }
}
