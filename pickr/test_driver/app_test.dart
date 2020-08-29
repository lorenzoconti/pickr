import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  Future<bool> isPresent(SerializableFinder byValueKey, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 1)}) async {
    try {
      await driver.waitFor(byValueKey, timeout: timeout);
      return true;
    } catch (exception) {
      return false;
    }
  }

  group('Pickr Test Driver', () {
    //
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final button = find.byValueKey('login_button');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    test('Pickr App', () async {
      //
      var health = await driver.checkHealth();
      print(health.status);
      //
      await driver.tap(emailField);
      await driver.enterText('lorenzoconti@gmail.com');
      await driver.waitFor(find.text('lorenzoconti@gmail.com'));
      await Future.delayed(Duration(seconds: 1));
      //
      await driver.tap(passwordField);
      await driver.enterText('password');
      await driver.waitFor(find.text('password'));
      await Future.delayed(Duration(seconds: 1));
      //
      await driver.tap(button);
      await Future.delayed(Duration(seconds: 1));
      //
      var found = await isPresent(find.byValueKey('create_lobby'), driver);
      expect(found, false);
      //
      await Future.delayed(Duration(seconds: 1));
      await driver.waitFor(find.text('BRISCOLA'));
      await driver.tap(find.byValueKey('BRISCOLA'));
      await Future.delayed(Duration(seconds: 1));
      //
      await driver.waitFor(find.text('numPlayers'));
      await driver.tap(find.byValueKey('numPlayers2'));
      await Future.delayed(Duration(seconds: 1));
      //
      await driver.waitFor(find.text('maxScore'));
      await driver.tap(find.byValueKey('maxScore10'));
      await Future.delayed(Duration(seconds: 1));
      //
      found = await isPresent(find.byValueKey('create_lobby'), driver);
      expect(found, true);
      //
      await driver.tap(find.byValueKey('create_lobby'));
      await Future.delayed(Duration(seconds: 1));
      //
      await Future.delayed(Duration(seconds: 1));
      await driver.waitFor(find.text('Game Lobby'));
    });
  });
}
