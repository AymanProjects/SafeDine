import 'package:SafeDine/Interfaces/DatabaseModel.dart';
import 'package:SafeDine/Services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ItemDetails.dart';

enum OrderStatus {
  BeingPrepared,
  Served,
  Cancelled,
}

class Order implements DatabaseModel{
  String _tableNumber;
  double _totalPrice;
  String _paymentType;
  String _date;
  List<ItemDetails> _itemDetails;
  String _status;
  String _visitorID;
  String _branchID;
  @override
  String id;


  Order({String tableNumber, double totalPrice, String paymentType, String date, List<ItemDetails> itemDetails, String visitorID, String branchID, String status, String id}){
    this._tableNumber = tableNumber;
    this._totalPrice = totalPrice;
    this._paymentType = paymentType;
    this._date = date;
    this._itemDetails = itemDetails;
    this._visitorID = visitorID;
    this._branchID = branchID;
    setStatus(status);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'tableNumber': getTableNumber() ?? '',
      'totalPrice': getTotalPrice() ?? 0.00,
      'paymentType': getPaymentType() ?? 'cash',
      'date': getDate() ?? DateTime.now().toString(),
      'itemDetails': getItemDetails()?.map((item) {
        return item?.toJson();
      })?.toList() ?? [],
      'status': getStatus() ?? 'BeingPrepared',
      'visitorID': getVisitorID() ?? '',
      'branchID': getBranchID() ?? '',
    };
  }

  @override
  Order fromJson(Map json){
     return new Order(
       id: json['id'] ?? '',
       tableNumber: json['tableNumber'] ?? '',
       totalPrice: json['totalPrice'] ?? 0.00,
       paymentType: json['paymentType'] ?? 'cash',
       date: json['date'] ?? 'unknown',
       itemDetails: json['itemDetails']?.map<ItemDetails>((json) {
         return ItemDetails().fromJson(json);
       })?.toList() ?? [],
       status: json['status'] ?? 'unknown',
       visitorID: json['visitorID'] ?? '',
       branchID: json['branchID'] ?? '',
     );
  }

  @override
  Future<Order> fetch(String id) async{
    DocumentSnapshot doc = await Database().getDocument(id, Database.ordersCollection);
    return fromJson(doc.data);
  }

  @override
  Future updateOrCreate() async{
    await Database().setDocument(this, Database.ordersCollection);
  }


  String getStatus() => _status;

  String getBranchID() => _branchID;

  String getVisitorID() => _visitorID;

  List<ItemDetails> getItemDetails() => _itemDetails;

  String getDate() => _date;

  String getPaymentType() => _paymentType;

  double getTotalPrice() => _totalPrice;

  String getTableNumber() => _tableNumber;


  setTotalPrice(double value) {
    _totalPrice = value;
  }

  setItemDetails(List<ItemDetails> value) {
    _itemDetails = value;
  }

  setStatus(String value) {
    try {
      if(value != null)
      _status = value.substring(value.indexOf('.') + 1);
    }catch (e){
      print(e.toString());
    }
  }
}
