import 'dart:ui';
import 'package:SafeDine/Models/FoodItem.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight, collapsedHeight;
  final FoodItem item;

  ItemDetailAppBar(
      {@required this.expandedHeight, this.item, this.collapsedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image(
          image: CachedNetworkImageProvider(item.getUrl()),
          fit: BoxFit.cover,
        ),

        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: (shrinkOffset / expandedHeight) * 5,
                sigmaY: (shrinkOffset / expandedHeight) * 5),
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
            ),
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 25, top: 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Provider.of<AppTheme>(context,listen: false).grey.withOpacity(0.5),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.clear_rounded, size: 22),
                color: Colors.white,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),

        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 33),
              child: Opacity(
                opacity: shrinkOffset / expandedHeight,
                child: Text(
                  item.getName(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ),
            ),
          ],
        ),
        //   Text('button'),
        //  Align(alignment: Alignment.center, child: Text('name')),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
