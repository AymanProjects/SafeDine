import 'package:SafeDine/Services/Authentication.dart';
import 'package:SafeDine/Services/Database.dart';
import 'package:SafeDine/Services/Notifications.dart';
import 'package:SafeDine/Services/PayPal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majascan/majascan.dart';
import 'Account.dart';
import '../Interfaces/DatabaseModel.dart';
import 'Order.dart';

class Visitor extends Account implements DatabaseModel {
  @override
  String id;

  Visitor({String id, String email, String password})
      : super(email: email, password: password) {
    this.id = id;
  }

  Future<void> placeOrder({Order order, BuildContext context}) async {
    if (order.getPaymentType() == 'paypal') {
      await PayPal.pay(context, order);
      await Database.setDocument(order, Database.ordersCollection);
    }
  }

  Future<void> cancelOrder(Order order) async {
    order.setStatus(OrderStatus.Cancelled.toString());
    await order.updateOrCreate();
  }

  Future<String> scanQR() async {
    return await MajaScan.startScan(
      title: "Scanning...",
      titleColor: Colors.white,
      qRCornerColor: Colors.white,
      qRScannerColor: Colors.white,
    );
  }

  Future<void> callWaiter(String branchID, String message) async {
    await Notifications.sendNotificationTo(
      branchID: branchID,
      message: message,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': getID(),
      'email': super.getEmail(),
    };
  }

  @override
  Visitor fromJson(Map json) {
    if (json == null) return Visitor();
    return new Visitor(
      id: json['id'],
      email: json['email'],
    );
  }

  @override
  Future<Visitor> fetch(String id) async {
    DocumentSnapshot doc =
        await Database.getDocument(id, Database.visitorsCollection);
    return fromJson(doc.data);
  }

  @override
  Future updateOrCreate() async {
    await Database.setDocument(this, Database.visitorsCollection);
  }

  @override
  Future<void> login() async {
    return await Authentication.login(this);
  }

  @override
  Future<void> logout() async {
    return await Authentication.signOut();
  }

  @override
  Future<void> register() async {
    return await Authentication.register(this);
  }

  @override
  Future<void> forgotPassword() async {
    await Authentication.forgotPassword(email: getEmail());
  }

  @override
  String getID() {
    return id;
  }

  @override
  void setID(String id) {
    this.id = id;
  }
}
