import 'FoodItem.dart';

class Category {
  String _name;
  List<FoodItem> _items;

  Category({String name, List<FoodItem> items}){
    this._name = name;
    this._items = items;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': getName() ?? 'Unnamed category',
      'items': getItems()?.map((item) {
        return item?.toJson();
      })?.toList() ?? [],
    };
  }

  Category fromJson(Map json){
    return new Category(
      name: json['name'] ?? 'Unnamed category',
      items: json['items']?.map<FoodItem>((json) {
        return FoodItem().fromJson(json);
      })?.toList() ?? [],
    );
  }

  List<FoodItem> getItems() => _items;
  String getName() => _name;

  setAddOns(List<FoodItem> value) {
    _items = value;
  }
  setName(String value) {
    _name = value;
  }

}