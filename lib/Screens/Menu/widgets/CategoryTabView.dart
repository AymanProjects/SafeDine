import 'package:SafeDine/Models/Category.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Models/Restaurant.dart';
import 'package:flutter/material.dart';

import 'FoodItemCard.dart';

class CategoryTabView extends StatelessWidget {
  final Restaurant restaurant;
  CategoryTabView(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: restaurant
          .getMenu()
          .map((category) => categoryItems(category))
          .toList(),
    );
  }

  Widget categoryItems(Category category) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      separatorBuilder: (context, _) => Container(
        height: 10,
      ),
      itemCount: category.getItems().length,
      itemBuilder: (context, index) {
        return FoodItemCard(
            itemDetails: ItemDetails(
                item: category.getItems()[index],
                quantity: 1,
                selectedAddOns: []));
      },
    );
  }
}
