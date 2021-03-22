import 'package:SafeDine/Models/Cart.dart';
import 'package:SafeDine/Models/FoodItem.dart';
import 'package:SafeDine/Models/ItemDetails.dart';
import 'package:SafeDine/Models/Order.dart';
import 'package:SafeDine/Models/Visitor.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  LiveTestWidgetsFlutterBinding();

  test(
    'The method "addToCart" should increase the quantity if an item already exists',
    () {
      Cart cart = Cart();
      FoodItem item = FoodItem();
      ItemDetails itemDetails = ItemDetails(item: item);
      cart.addToCart(itemDetails);
      cart.addToCart(itemDetails);
      expect(itemDetails.getQuantity(), 2);
    },
  );

  test(
    'The method "fromJson" should return a Visitor object if the json is valid',
    () {
      Map json = {
        'id': '12345',
        'email': 'example@example.com',
      };
      Visitor visitor = Visitor().fromJson(json);
      expect(visitor, isInstanceOf<Visitor>());
    },
  );

  test(
    'The method "getReadableDate" should return a formatted date',
    () {
      String date = '2021-02-21 20:33:48.747966';
      String readableDate = Order(date: date).getReadableDate();
      expect(readableDate, '21-02-2021 8:33 PM');
    },
  );
}
