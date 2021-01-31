import 'package:SafeDine/Models/AddOn.dart';
import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Screens/Menu/ItemDetailScreen.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/SafeDineSnackBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final ItemDetails itemDetails;

  CartItemCard({this.itemDetails});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) {
                return ItemDetailScreen(
                  itemDetails: itemDetails,
                  buttonText: 'Update',
                  buttonFunction: () {
                    cart.updateCart();
                  },
                );
              },
            ));
          },
          child: Stack(children: [
            Container(
              height: 80.w,
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      spreadRadius: -1,
                      offset: Offset(0, 2)),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.w),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(7.w)),
                    child: Container(
                        width: 65.w,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                              height: 6.w,
                            ),
                            Text(
                                getSelectedAddOnNames(
                                    itemDetails.getSelectedAddOns()),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Provider.of<AppTheme>(context,
                                          listen: false)
                                      .grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                        Text(
                            'SAR ${itemDetails.getTotalSelectionPrice().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          cart.removeFromCart(itemDetails);

                          SafeDineSnackBar.showNotification(
                            type: SnackbarType.Error,
                            context: context,
                            msg: "Item Removed",
                            actionName: 'Undo',
                            onActionTap: () {
                              cart.addToCart(itemDetails);
                            },
                          );
                        },
                        child: Icon(
                          Icons.clear,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                    '${itemDetails.getQuantity()}',
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
              ),
            ),
          ]),
        );
  }

  String getSelectedAddOnNames(List<AddOn> addOns) {
    String names = '';
    for (AddOn addon in addOns) {
      names += ', ${addon.getName()}';
    }
    if (names.length > 0) names = names.substring(2); // remove the first coma ,
    return names;
  }
}
