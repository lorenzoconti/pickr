import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Pickr Test Driver', () {
    //
    final emailField = find.byValueKey("email");
    final passwordField = find.byValueKey("password");
    final button = find.byValueKey("login_button");

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    test('something', () async {
      await driver.tap(emailField);
      await driver.enterText("lorenzo.conti@gmail.com");
      await driver.waitFor(find.text('lorenzo.conti@gmail.com'));
      await driver.tap(passwordField);
      await driver.enterText("password");
      await driver.waitFor(find.text('password'));
      await driver.tap(button);
    });
  });
}
