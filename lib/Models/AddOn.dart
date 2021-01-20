
class AddOn{
  String _name;
  double _price;

  AddOn({String name, double price}){
    this._name = name;
    this._price = price;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': getName() ?? 'Unnamed',
      'price': getPrice() ?? 0.00,
    };
  }

  AddOn fromJson(Map json){
    return new AddOn(
      name: json['name'] ?? 'Unnamed',
      price: json['price'] ?? 0.00,
    );
  }

  double getPrice() => _price;
  String getName() => _name;

  setPrice(double value) {
    _price = value;
  }
  setName(String value) {
    _name = value;
  }
}