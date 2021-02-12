import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Screens/Menu/widgets/CategoryTabView.dart';
import 'package:SafeDine/Screens/Menu/widgets/MenuAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant =
        Provider.of<Restaurant>(context, listen: false);
    return DefaultTabController(
      initialIndex: 0,
      length: restaurant.getMenu().length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(0, 100),
          child: MenuAppBar(
            restaurant: restaurant,
          ),
        ),
        body: CategoryTabView(restaurant),
      ),
    );
  }
}
