import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Models/Order.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Screens/Authentication/AuthScreen.dart';
import 'package:SafeDine/Screens/Cart/widgets/AddNoteField.dart';
import 'package:SafeDine/Screens/Cart/widgets/CartItemCard.dart';
import 'package:SafeDine/Screens/Cart/widgets/CartSubtotal.dart';
import 'package:SafeDine/Screens/Home/widgets/ScreenIndex.dart';
import 'package:SafeDine/Services/FirebaseException.dart';
import 'package:SafeDine/Widgets/GlobalScaffold.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:SafeDine/Widgets/SafeDineSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/PaymentMethodSelection.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _loading = false;
  int _selectedPaymentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // if an item is added or removed, this widget will rebuild
    final Cart cart = Provider.of<Cart>(context, listen: true);

    return GlobalScaffold(
      hasDrawer: true,
      title: 'Order Details',
      body: cart.getItems().length > 0
          ? showCartItems(cart.getItems())
          : showCartIsEmpty(),
    );
  }

  Widget showCartItems(List<ItemDetails> items) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
        separatorBuilder: (context, _) => Container(
          height: 10,
        ),
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index == items.length) {
            return closureWidget();
          }
          return CartItemCard(
            itemDetails: items[index],
          );
        },
      ),
    );
  }

  Widget closureWidget() {
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final visitor = Provider.of<Visitor>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20),
      child: Column(
        children: [
          CartSubtotal(),
          SizedBox(
            height: 20,
          ),
          AddNoteField(
            savedValue: cart.getNote(),
            onNoteChanged: (note) {
              cart.setNote(note);
            },
          ),
          SizedBox(
            height: 20,
          ),
          PaymentMethodSelection(
            onMethodChanged: (value) {
              setState(() {
                _selectedPaymentIndex = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          SafeDineButton(
            color: _selectedPaymentIndex == 1
                ? Colors.green
                : Theme.of(context).primaryColor,
            text: _selectedPaymentIndex == 1
                ? 'Place order'
                : 'Proceed to payment',
            loading: _loading,
            function: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              setState(() {
                _loading = true;
              });

              if (visitor.getID() != null) {
                // if signed in
                // TODO: provide restaurant and branch
                Order order = new Order(
                  note: cart.getNote(),
                  restaurantName: 'KFC',
                  branchID: '',
                  date: DateTime.now().toString(),
                  status: OrderStatus.BeingPrepared.toString(),
                  paymentType: _selectedPaymentIndex == 1 ? 'cash' : 'paypal',
                  tableNumber: '7',
                  totalPrice: cart.getTotalPrice(),
                  visitorID: visitor.getID(),
                  itemDetails: cart.getItems(),
                );

                try {
                  await visitor.placeOrder(order);
                  cart.clearCart();
                  SafeDineSnackBar.showNotification(
                    duration: 2,
                    context: context,
                    msg: 'Order sent 👍',
                    type: SnackbarType.Success,
                  );
                  Provider.of<ScreenIndex>(context, listen: false)
                      .setScreenIndex(0);
                } on PlatformException catch (e) {
                  SafeDineSnackBar.showNotification(
                    duration: 2,
                    context: context,
                    msg: FirebaseException.generateReadableMessage(e),
                    type: SnackbarType.Error,
                  );
                } catch (e) {
                  SafeDineSnackBar.showNotification(
                      context: context,
                      msg: 'Undefined error happened',
                      type: SnackbarType.Error);
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              }
              setState(() {
                _loading = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget showCartIsEmpty() {
    return Expanded(
      child: Center(
        child: Text(
          'Cart is Empty, add items from the menu tab',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
