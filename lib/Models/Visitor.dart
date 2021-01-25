import 'package:SafeDine/Services/Authentication.dart';
import 'package:SafeDine/Services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Account.dart';
import '../Interfaces/DatabaseModel.dart';
import 'Order.dart';

class Visitor extends Account implements DatabaseModel{
  @override
  String id;

  Visitor({String id, String email, String password}): super(email: email, password: password){
    this.id = id;
  }

  Future<void> placeOrder(Order order) async{
    try {
      await Database().setDocument(order, Database.ordersCollection);
//      if (payment != null) // if in-app payment is chosen
//        await payment.pay();
    }catch(e){
      Database().deleteDocument(order.id, Database.ordersCollection);
      rethrow;
    }
  }

  Future<void> cancelOrder(Order order) async{
    order.setStatus(OrderStatus.Cancelled.toString());
    await Database().setDocument(order, Database.ordersCollection);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': getID(),
      'email': super.getEmail(),
    };
  }

  @override
  Visitor fromJson(Map json){
    if (json == null) return Visitor();
    return new Visitor(
      id: json['id'],
      email: json['email'],
    );
  }

  @override
  Future<Visitor> fetch(String id) async{
    DocumentSnapshot doc = await Database().getDocument(id, Database.visitorsCollection);
    return fromJson(doc.data);
  }

  @override
  Future updateOrCreate() async{
    await Database().setDocument(this, Database.visitorsCollection);
  }

  @override
  Future<void> login() async{
    return await Authentication().login(this);
  }
  @override
  Future<void> logout() async{
    return await Authentication().signOut();
  }
  @override
  Future<void> register() async{
    return await Authentication().register(this);
  }

   @override
  String getID() {
    return id ?? '';
  }

  @override
  void setID(String id) {
    this.id = id;
  }
}