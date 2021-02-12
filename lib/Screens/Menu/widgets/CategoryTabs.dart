import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class CategoryTabs extends StatelessWidget {
  final Restaurant restaurant;
  CategoryTabs(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Provider.of<AppTheme>(context, listen: false).primary,
          unselectedLabelColor:
              Provider.of<AppTheme>(context, listen: false).grey,
          isScrollable: true,
          tabs: restaurant.getMenu().map((category) {
            return tabItem(name: category.getName(), context: context);
          }).toList(),
          indicator: MaterialIndicator(
            height: 2,
            color: Theme.of(context).primaryColor,
            bottomLeftRadius: 20,
            bottomRightRadius: 20,
            topLeftRadius: 20,
            topRightRadius: 20,
          ),
        ),
      ),
    );
  }

  Widget tabItem({String name, context}) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          name,
          style: TextStyle(fontSize: 14),
        ));
  }
}
