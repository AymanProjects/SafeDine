import 'package:SafeDine/Models/Order.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:SafeDine/Screens/OrderProgress/widgets/OrderCard.dart';
import 'package:SafeDine/Services/Database.dart';
import 'package:SafeDine/Widgets/GlobalScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProgressScreen extends StatefulWidget {
  @override
  _OrderProgressScreenState createState() => _OrderProgressScreenState();
}

class _OrderProgressScreenState extends State<OrderProgressScreen> {
  @override
  Widget build(BuildContext context) {
    Visitor visitor = Provider.of<Visitor>(context, listen: true);

    return GlobalScaffold(
      hasDrawer: true,
      title: 'Order Progress',
      body: visitor.getID() != null
          ? getUserOrder(context: context, userID: visitor.getID())
          : showNoActiveOrder(),
    );
  }

  Widget getUserOrder({context, String userID}) {
    return StreamBuilder<List<Order>>(
      stream: Database.getOrdersOfVisitorWhere(
          status: 'BeingPrepared', visitorID: userID),
      builder: (_, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0)
            return showActiveOrders(snapshot.data);
          else
            return showNoActiveOrder();
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget showActiveOrders(List<Order> activeOrders) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(15),
        separatorBuilder: (context, _) => Container(
          height: 20,
        ),
        itemCount: activeOrders.length,
        itemBuilder: (context, index) {
          return OrderCard(index: index, order: activeOrders[index]);
        },
      ),
    );
  }

  Widget showNoActiveOrder() {
    return Expanded(
      child: Center(
        child: Text(
          'There are no active orders, place a new one first',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
