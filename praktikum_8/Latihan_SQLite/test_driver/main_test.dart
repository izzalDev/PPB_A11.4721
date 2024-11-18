import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  group('Counter App Test', () {
    late FlutterDriver driver;
    final tfEmail = find.byValueKey('tf_email');
    final tfPassword = find.byValueKey('tf_password');
    final txtEmail = find.byValueKey('txt_email');
    final txtPassword = find.byValueKey('txt_password');
    final btnGet = find.byValueKey('btn_get');
    final btnSet = find.byValueKey('btn_set');

    setUpAll(() async {
      Directory('screenshots').deleteSync(recursive: true);
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    Future<void> takeScreenshot(FlutterDriver driver, String name) async {
      try {
        final pixels = await driver.screenshot();
        final file = File('screenshots/$name.png');
        file.createSync(recursive: true);
        file.writeAsBytesSync(pixels);
        print('Screenshot taken: $name.png');
      } catch (e) {
        print('Error taking screenshot: $e');
      }
    }

    test('Set email and password', () async {
      await takeScreenshot(driver, 'initial_page');
      await driver.tap(tfEmail);
      await driver.enterText('rizal.fadlullah@gmail.com');
      await driver.tap(tfPassword);
      await driver.enterText('1234567');
      await driver.tap(btnSet);
      await takeScreenshot(driver, 'set_email_password');
    });

    test('Get email and password', () async {
      await driver.tap(btnGet);
      expect(await driver.getText(txtEmail),
          'Your Email : rizal.fadlullah@gmail.com');
      expect(await driver.getText(txtPassword), 'Your Password : 1234567');
      await takeScreenshot(driver, 'get_email_password');
    });
  });
}
