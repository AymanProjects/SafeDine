import 'package:flutter/foundation.dart';
import 'ItemDetails.dart';

class Cart with ChangeNotifier {
  List<ItemDetails> _items;
  String _note;

  Cart() {
    this._items = [];
    _note = '';
  }

  void addToCart(ItemDetails item) {
    //check if the list does not contain an identical copy of item. if so, just increment the quantity
    ItemDetails identicalCopy;
    for (ItemDetails itemDetails in getItems()) {
      if (itemDetails.getItem() == item.getItem() &&
          listEquals(
              itemDetails.getSelectedAddOns(), item.getSelectedAddOns())) {
        identicalCopy = itemDetails;
        break;
      }
    }
    if (identicalCopy != null)
      identicalCopy.increaseQuantityBy(item.getQuantity());
    else
      this._items.add(item);

    notifyListeners();
  }

  void removeFromCart(ItemDetails item) {
    this._items.remove(item);
    notifyListeners();
  }

  List<ItemDetails> getItems() => this._items;
  String getNote() => this._note;

  void setNote(String note) {
    this._note = note;
  }

  double getTotalPrice() {
    double total = 0.00;
    _items.forEach((itemDetails) {
      total += itemDetails.getTotalSelectionPrice();
    });
    return total;
  }

  void updateCart() {
    notifyListeners();
  }

  void clearCart() {
    this._items.clear();
    this._note = '';
  }
}
