import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Screens/Home/widgets/ScreenIndex.dart';
import 'package:SafeDine/Screens/Menu/ItemDetailScreen.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/SafeDineSnackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodItemCard extends StatelessWidget {
  final ItemDetails itemDetails;
  FoodItemCard({this.itemDetails});

  @override
  Widget build(BuildContext context) {
    ScreenIndex homeScreenIndexProvider = Provider.of<ScreenIndex>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) {
            return ItemDetailScreen(
              itemDetails: itemDetails,
              buttonText: 'Add to Cart',
              buttonFunction: () {
                Provider.of<Cart>(context, listen: false)
                    .addToCart(itemDetails);
                SafeDineSnackBar.showNotification(

                  type: SnackbarType.CartNotification,
                  context: context,
                  msg: 'Added to Cart',
                  ontap: () {
                   homeScreenIndexProvider.setScreenIndex(2);
                  }
                  );
              },
            );
          },
        ));
      },
      child: Container(
        height: 110.w,
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: -1,
                offset: Offset(0, 1))
          ],
          color: Provider.of<AppTheme>(context,listen: false).white,
          borderRadius: BorderRadius.circular(7.w),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(7.w)),
              child: Container(
                  width: 90.w,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: itemDetails.getItem().getUrl(),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemDetails.getItem().getName(),
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 3.w,
                  ),
                  Text(
                    itemDetails.getItem().getDescription(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Provider.of<AppTheme>(context, listen: false).grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'SAR ${itemDetails.getItem().getPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'meduim',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
