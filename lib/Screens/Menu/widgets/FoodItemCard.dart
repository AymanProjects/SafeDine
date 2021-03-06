import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Screens/Home/widgets/ScreenIndex.dart';
import 'package:SafeDine/Screens/Menu/ItemDetailScreen.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Services/FlashSnackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodItemCard extends StatelessWidget {
  final ItemDetails itemDetails;
  final int index;
  FoodItemCard({this.itemDetails, this.index});

  @override
  Widget build(BuildContext context) {
    ScreenIndex homeScreenIndexProvider =
        Provider.of<ScreenIndex>(context, listen: false);
    return InkWell(
      key: ValueKey('foodItem$index'),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) {
            return ItemDetailScreen(
              itemDetails: itemDetails,
              buttonText: 'Add to Cart',
              buttonFunction: (ItemDetails modfiedItemDetails) {
                Provider.of<Cart>(context, listen: false)
                    .addToCart(modfiedItemDetails);
                FlashSnackBar.success(
                  message: 'Added to Cart',
                  onTap: () {
                    homeScreenIndexProvider.setScreenIndex(2);
                  },
                );
              },
            );
          },
        ));
      },
      child: Container(
        height: 110,
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: -1,
                offset: Offset(0, 1))
          ],
          color: Provider.of<AppTheme>(context, listen: false).white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              child: Hero(
                tag: itemDetails.getItem().hashCode,
                child: Container(
                    width: 90,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: itemDetails.getItem().getUrl(),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemDetails.getItem().getName(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    itemDetails.getItem().getDescription(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Provider.of<AppTheme>(context, listen: false).grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
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
                    fontSize: 11,
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
