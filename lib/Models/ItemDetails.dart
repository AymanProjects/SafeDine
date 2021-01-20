import 'package:SafeDine/Models/FoodItem.dart';

class ItemDetails{
  FoodItem _item;
  int _quantity;

  ItemDetails({FoodItem item, int quantity}){
    this._item = item;
    this._quantity = quantity;
  }

  Map<String, dynamic> toJson() {
    return{
      'item': getItem()?.toJson() ?? FoodItem().toJson(),
      'quantity': getQuantity() ?? 1,
    };
  }

  ItemDetails fromJson(Map json){
    return new ItemDetails(
      item: FoodItem().fromJson(json['item'] ?? {}),
      quantity: json['quantity'] ?? 1,
    );
  }

  FoodItem getItem() => _item;
  int getQuantity() => _quantity;

  setItem(FoodItem value) {
    _item = value;
  }
  setQuantity(int value) {
    _quantity = value;
  }
}