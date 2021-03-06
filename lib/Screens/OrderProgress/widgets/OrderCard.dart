import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Models/Order.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Services/FirebaseException.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Services/FlashSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final int index;
  OrderCard({this.index, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.getStatus(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  )),
              Text(
                "SAR ${order.getTotalPrice().toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Divider(
            color: Provider.of<AppTheme>(context).grey,
            height: 30,
          ),
          Text(
            "Order Details:",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 210,
            child: Text(
              getItemsNames(order.getItemDetails()),
              style: TextStyle(
                fontSize: 12,
                color: Provider.of<AppTheme>(context).grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              order.getPaymentType() == 'cash'
                  ? InkWell(
                      key: ValueKey('order$index'),
                      child:
                          Text('cancel', style: TextStyle(color: Colors.red)),
                      onTap: () {
                        showConfirmationDialog(context, order);
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  showConfirmationDialog(context, order) {
    FlashSnackBar.showConfirmationDialog(
      message: 'Do you really want to cancel this order? \n',
      positiveActionText: Text(
        'Yes',
        key: ValueKey('cancelOrder'),
        style: TextStyle(color: Colors.red, fontSize: 14),
      ),
      positiveAction: () async {
        try {
          Visitor visitor = Provider.of<Visitor>(context, listen: false);
          await visitor.cancelOrder(order);
        } on PlatformException catch (exception) {
          FlashSnackBar.error(
            message: FirebaseException.generateReadableMessage(exception),
          );
        }
      },
      negativeActionText: Text(
        'No',
        style: TextStyle(fontSize: 14),
      ),
      negativeAction: () {
        // no code needed
      },
    );
  }

  String getItemsNames(List<ItemDetails> itemDetails) {
    String names = '';
    for (ItemDetails item in itemDetails) {
      names += ', ${item.getItem().getName()}';
    }
    if (names.length > 0) names = names.substring(2); // remove the first coma ,
    return names;
  }
}
