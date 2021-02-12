import 'package:SafeDine/Models/FoodItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemDetailAppBar extends StatelessWidget {
  final FoodItem item;
  ItemDetailAppBar({this.item});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      expandedHeight: 160,
      leading: Container(
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.4),
        ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear_rounded,
            size: 22,
          ),
          color: Colors.white,
          padding: EdgeInsets.zero,
        ),
      ),
      flexibleSpace: Image(
        image: CachedNetworkImageProvider(item.getUrl()),
        fit: BoxFit.cover,
      ),
    );
  }
}
