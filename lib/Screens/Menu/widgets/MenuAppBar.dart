import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Screens/Home/HomeScreen.dart';
import 'package:SafeDine/Screens/Menu/widgets/DrawerIcon.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              blurRadius: 1,),
        ],
      ),
      child: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor:Provider.of<AppTheme>(context,listen: false).white,
        title: Text(
          restaurant.getName(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 26.sp,
          ),
        ),
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            InkWell(
              onTap: () {
                  Provider.of<HomeDrawerState>(context, listen: false).key.currentState.openDrawer();
                },
              child: DrawerIcon(
                width: 22.w,
                hieght: 2.w,
                spaceBetween: 4.w,
                leftPadding: 15.w,
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
