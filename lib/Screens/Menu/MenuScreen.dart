import 'package:SafeDine/Models/AddOn.dart';
import 'package:SafeDine/Models/Category.dart';
import 'package:SafeDine/Models/FoodItem.dart';
import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Screens/Menu/widgets/CategoryTabView.dart';
import 'package:SafeDine/Screens/Menu/widgets/MenuAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: restaurant.getMenu().length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(0, 115.h),
          child: MenuAppBar(
            restaurant: restaurant,
          ),
        ),
        body: CategoryTabView(restaurant),
      ),
    );
  }

  final restaurant = Restaurant(name: 'Al-baik', menu: [
    Category(name: 'Chicken', items: [
      FoodItem(
        name: 'Checken Mac Burger',
        price: 7,
        description: 'A very tasty burger served by the best restaurant',
        addOns: [
          AddOn(name: 'Onion', price: 1),
          AddOn(name: 'Cheese', price: 2),
          AddOn(name: 'Tomato', price: 5.0),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
    ]),
    Category(name: 'Steak', items: [
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
    ]),
    Category(name: 'Breakfast', items: [
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
    ]),
    Category(name: 'Drinks', items: [
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
    ]),
    Category(name: 'Extra', items: [
      FoodItem(
        name: 'Musahhab',
        price: 7,
        description: 'Sandwitch',
        addOns: [
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
          AddOn(name: 'ddd', price: 10.00),
        ],
        imageUrl:
            'https://nishkitchen.com/wp-content/uploads/2012/02/Beef-Burger-Patty-2-Ways-1B.jpg',
      ),
    ]),
  ]);
}
