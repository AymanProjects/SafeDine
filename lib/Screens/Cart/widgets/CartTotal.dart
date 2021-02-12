import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context, listen: false);
    const double TAX = 0.15;

    double totalBeforeTax =
        cart.getTotalPrice() - ((cart.getTotalPrice() / (1 + TAX)) * TAX);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'SAR ${totalBeforeTax.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              'SAR ${(totalBeforeTax * TAX).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              'SAR ${(cart.getTotalPrice()).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Provider.of<AppTheme>(context, listen: false).primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
