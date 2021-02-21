import 'package:SafeDine/Utilities/Validations.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  LiveTestWidgetsFlutterBinding();

  test(
    'when passing an empty or null value to the method "isEmptyValidation", it should return an error that says "field cant be empty"',
    () {
      String emptyString = '';
      String result = Validations.isEmptyValidation(emptyString);
      expect(result, 'field can\'t be empty');
    },
  );

  test(
    'when passing a non-empty value to the method "isEmptyValidation", it should return null',
    () {
      String notEmptyString = 'Hi';
      String result = Validations.isEmptyValidation(notEmptyString);
      expect(result, null);
    },
  );

  test(
    'when passing a badly formatted email to the method "emailValidation", it should return an error that says "invalid email format"',
    () {
      String badlyFormatted = 'example@com';
      String result = Validations.emailValidation(badlyFormatted);
      expect(result, 'invalid email format');
    },
  );

  test(
    'when passing a valid email to the method "emailValidation", it should return null',
    () {
      String validEmail = 'example@example.com';
      String result = Validations.emailValidation(validEmail);
      expect(result, null);
    },
  );

  test(
    'Rhe method "passwordValidation" should return an error that says "minimum 6 characters", if the value is less than 6 characters',
    () {
      String password = '12345';
      String result = Validations.passwordValidation(password);
      expect(result, 'minimum 6 characters');
    },
  );

  test(
    'Rhe method "passwordValidation" should return null if the value is more than or equal to 6 characters',
    () {
      String password = '123456';
      String result = Validations.passwordValidation(password);
      expect(result, null);
    },
  );
}
