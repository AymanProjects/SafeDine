import 'package:SafeDine/Models/Branch.dart';
import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Models/Order.dart';
import 'package:SafeDine/Models/Restaurant.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Providers/TableNumber.dart';
import 'package:SafeDine/Screens/Authentication/AuthScreen.dart';
import 'package:SafeDine/Screens/Cart/widgets/AddNoteField.dart';
import 'package:SafeDine/Screens/Cart/widgets/CartItemCard.dart';
import 'package:SafeDine/Screens/Cart/widgets/CartTotal.dart';
import 'package:SafeDine/Screens/Home/widgets/ScreenIndex.dart';
import 'package:SafeDine/Services/FirebaseException.dart';
import 'package:SafeDine/Widgets/GlobalScaffold.dart';
import 'package:SafeDine/Widgets/SafeDineButton.dart';
import 'package:SafeDine/Services/FlashSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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
        key: ValueKey('cartList'),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
            index: index,
          );
        },
      ),
    );
  }

  Widget closureWidget() {
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final Visitor visitor = Provider.of<Visitor>(context, listen: false);
    final Restaurant restaurant =
        Provider.of<Restaurant>(context, listen: false);
    final Branch branch = Provider.of<Branch>(context, listen: false);
    final TableNumber tableNumber =
        Provider.of<TableNumber>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Column(
        children: [
          CartTotal(),
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
            key: ValueKey('placeOrderButton'),
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
                Order order = new Order(
                  note: cart.getNote(),
                  restaurantName: restaurant.getName(),
                  branchID: branch.getID(),
                  date: DateTime.now().toString(),
                  status: OrderStatus.Pending.toString(),
                  paymentType: _selectedPaymentIndex == 1 ? 'cash' : 'paypal',
                  tableNumber: tableNumber.number,
                  totalPrice: cart.getTotalPrice(),
                  visitorID: visitor.getID(),
                  itemDetails: cart.getItems(),
                );

                try {
                  await visitor.placeOrder(context: context, order: order);
                  cart.clearCart();
                  FlashSnackBar.success(
                    duration: 2,
                    message: 'Order sent  👍',
                  );
                  Provider.of<ScreenIndex>(context, listen: false)
                      .setScreenIndex(0);
                } on PlatformException catch (exception) {
                  String errorMsg;
                  if (exception.code == 'paymentCancelled')
                    errorMsg = 'Payment was cancelled';
                  else
                    errorMsg =
                        FirebaseException.generateReadableMessage(exception);
                  FlashSnackBar.error(message: errorMsg);
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
