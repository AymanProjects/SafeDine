import 'package:SafeDine/Interfaces/DatabaseModel.dart';
import 'package:SafeDine/Models/Order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Database {
  Database._();
  static String visitorsCollection = 'visitors';
  static String restaurantsCollection = 'restaurants';
  static String branchesCollection = 'branches';
  static String ordersCollection = 'orders';

  static Future<DocumentSnapshot> getDocument(
      String id, String collectionName) async {
    return await Firestore.instance
        .collection(collectionName)
        .document(id)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists)
        return doc;
      else
        throw new PlatformException(code: "Document not found");
    });
  }

  static Future<void> setDocument(
      DatabaseModel model, String collectionName) async {
    // 1. if object.id is null, this will generate a new id
    DocumentReference reference =
        Firestore.instance.collection(collectionName).document(model.id);
    // 2. assign the new id. If object.id was not null then object.id would already equal reference.documentID
    // so this line has no effect if object.id was not null
    model.id = reference.documentID;
    // 3. create or update
    await Firestore.instance
        .collection(collectionName)
        .document(model.id)
        .setData(model.toJson(), merge: true);
  }

  static Future<void> deleteDocument(String id, String collectionName) async {
    await Firestore.instance.collection(collectionName).document(id).delete();
  }

  static Stream<List<Order>> getOrdersOfVisitorWhere(
      {String status, String visitorID}) {
    return Firestore.instance
        .collection(ordersCollection)
        .where('visitorID', isEqualTo: visitorID)
        .where('status', isEqualTo: status)
        .orderBy('date')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return Order().fromJson(doc.data);
      }).toList();
    });
  }
}
