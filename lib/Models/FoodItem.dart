import 'AddOn.dart';

class FoodItem {
  String _name;
  double _price;
  String _description;
  List<AddOn> _addOns;
  String _imageUrl;

  FoodItem(
      {String name,
      double price,
      String description,
      List<AddOn> addOns,
      url}) {
    this._name = name;
    this._price = price;
    this._description = description;
    this._addOns = addOns;
    this._imageUrl = url;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': getName() ?? 'Unnamed Item',
      'price': getPrice() ?? 0.00,
      'description': getDescription() ?? 'No Additional Info.',
      'addOns': getAddOns()?.map((addon) {
            return addon?.toJson();
          })?.toList() ??
          [],
      'imageUrl': getUrl() ?? 'https://www.theemailcompany.com/wp-content/uploads/2016/02/no-image-placeholder-big.jpg',
    };
  }

  FoodItem fromJson(Map json) {
    return new FoodItem(
      name: json['name'] ?? 'Unnamed Item',
      price: json['price'] ?? 0.00,
      description: json['description'] ?? 'No Additional Info.',
      addOns: json['addOns']?.map<AddOn>((json) {
            return AddOn().fromJson(json);
          })?.toList() ??
          [],
      url: json['imageUrl'] ?? 'https://www.theemailcompany.com/wp-content/uploads/2016/02/no-image-placeholder-big.jpg',
    );
  }

  List<AddOn> getAddOns() => _addOns;
  String getDescription() => _description;
  double getPrice() => _price;
  String getName() => _name;
  String getUrl() => _imageUrl;

  setAddOns(List<AddOn> value) {
    _addOns = value;
  }

  setDescription(String value) {
    _description = value;
  }

  setPrice(double value) {
    _price = value;
  }

  setName(String value) {
    _name = value;
  }

  setUrl(String value) {
    _imageUrl = value;
  }
}
