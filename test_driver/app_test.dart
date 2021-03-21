import 'dart:io';
import 'dart:math';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
    await driver.waitUntilFirstFrameRasterized();
  });
  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  final scanQRButton = find.byValueKey('QRbutton');
  final progressPageTap = find.byValueKey('order progress page tap');
  final openDrawerButton = find.byValueKey('open drawer button');
  final drawerLoginButton = find.byValueKey('drawer login button');
  final drawerLogoutButton = find.byValueKey('drawer logout button');
  final registerPageTap = find.byValueKey('register page tap');
  final loginButton = find.byValueKey('LoginButton');
  final registerButon = find.byValueKey('RegisterButton');
  final emailRegisterField = find.byValueKey('emailRegisterField');
  final passwordRegisterField = find.byValueKey('passwordRegisterField');
  final emailLoginField = find.byValueKey('emailLoginField');
  final passwordLoginField = find.byValueKey('passwordLoginField');
  final menuPageTap = find.byValueKey('menu page tap');
  final cartPageTap = find.byValueKey('cart page tap');
  final foodItemCard0 = find.byValueKey('foodItem0');
  final foodItemCard1 = find.byValueKey('foodItem1');
  final addItemToCartButton = find.byValueKey('addItemToCartButton');
  final placeOrderButton = find.byValueKey('placeOrderButton');
  final cartList = find.byValueKey('cartList');
  final cancelOrderButton = find.byValueKey('order0');
  final confirmOrderCancel = find.byValueKey('cancelOrder');
  final editCartItem0 = find.byValueKey('editCartItem0');
  final increaseItemQuantity = find.byValueKey('increaseItemQuantity');
  final orderNoteField = find.byValueKey('orderNoteField');
  final deleteCartItem1 = find.byValueKey('deleteCartItem1');

  test('Visitor Registration', () async {
    await driver.tap(scanQRButton);
    await driver.tap(progressPageTap);
    await driver.tap(openDrawerButton);
    if (await isAvailable(drawerLogoutButton, driver)) {
      await driver.tap(drawerLogoutButton);
      await driver.tap(openDrawerButton);
    }
    await driver.tap(drawerLoginButton);
    await driver.tap(registerPageTap);
    await driver.tap(emailRegisterField);
    await driver.enterText(
      'user' + Random().nextInt(10000).toString() + '@gmail.com',
    );
    await driver.tap(passwordRegisterField);
    await driver.enterText('123456');
    await driver.tap(registerButon);
    sleep(Duration(seconds: 2));
  });

  test('Visitor Login', () async {
    await driver.tap(openDrawerButton);
    if (await isAvailable(drawerLogoutButton, driver)) {
      await driver.tap(drawerLogoutButton);
      await driver.tap(openDrawerButton);
    }
    await driver.tap(drawerLoginButton);
    await driver.tap(emailLoginField);
    await driver.enterText('user706@gmail.com');
    await driver.tap(passwordLoginField);
    await driver.enterText('123456');
    await driver.tap(loginButton);
    sleep(Duration(seconds: 2));
  });

  test('Add Item to Cart', () async {
    await driver.tap(menuPageTap);
    await driver.tap(foodItemCard0);
    await driver.tap(addItemToCartButton);
    await driver.tap(cartPageTap);
  });
  test('Add Another Item to Cart', () async {
    await driver.tap(menuPageTap);
    await driver.tap(foodItemCard1);
    await driver.tap(addItemToCartButton);
    await driver.tap(cartPageTap);
  });

  test('Update Cart', () async {
    sleep(Duration(seconds: 2));
    await driver.tap(editCartItem0);
    await driver.tap(increaseItemQuantity);
    await driver.tap(addItemToCartButton);
    await driver.tap(orderNoteField);
    await driver.enterText('Extra ketchup please');
    await driver.tap(deleteCartItem1);
    sleep(Duration(seconds: 2));
  });

  test('Place Order', () async {
    await driver.scroll(cartList, 0, -1000, Duration(seconds: 1));
    await driver.tap(placeOrderButton);
    sleep(Duration(seconds: 2));
  });

  test('Cancel Order', () async {
    await driver.tap(cancelOrderButton);
    await driver.tap(confirmOrderCancel);

    sleep(Duration(seconds: 2));
  });
}

Future<bool> isAvailable(SerializableFinder byValueKey, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (e) {
    return false;
  }
}
