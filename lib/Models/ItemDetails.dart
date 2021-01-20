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
      'item': getItem().toJson(),
      'quantity': getQuantity(),
    };
  }

  ItemDetails fromJson(Map json){
    if (json == null) return ItemDetails();
    return new ItemDetails(
      item: FoodItem().fromJson(json['item'] ?? {}),
      quantity: json['quantity'],
    );
  }

  FoodItem getItem() => _item ?? FoodItem();
  int getQuantity() => _quantity ?? 1;

  setItem(FoodItem value) {
    _item = value;
  }
  setQuantity(int value) {
    _quantity = value;
  }
}