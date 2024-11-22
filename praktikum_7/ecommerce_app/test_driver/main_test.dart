import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Test Ecommerce App', () {
    late FlutterDriver driver;
    late Directory screenshotDir;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      screenshotDir = Directory('screenshots');

      if (screenshotDir.existsSync()) {
        try {
          screenshotDir.deleteSync(recursive: true);
          print('Screenshot directory deleted successfully.');
        } catch (e) {
          print('Failed to delete screenshot directory: $e');
        }
      }

      try {
        screenshotDir.createSync(recursive: true);
        print('Screenshot directory created successfully.');
      } catch (e) {
        print('Failed to create screenshot directory: $e');
      }
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    Future<void> takeScreenshot(FlutterDriver driver, String name) async {
      try {
        final pixels = await driver.screenshot().;
        final file = File('screenshots/$name.png');
        file.createSync(recursive: true);
        file.writeAsBytesSync(pixels);
        print('Screenshot taken: $name.png');
      } catch (e) {
        print('Error taking screenshot: $e');
      }
    }

    test('Check Splashscreen', () async {
      final splashPage = find.byType('SplashPage');
      await driver.waitFor(splashPage);
      await takeScreenshot(driver, 'splash-screen');
      expect(splashPage, isNotNull, reason: 'SplashPage not found!');
    });

    test('Check Login Page', () async {
      final dialog = find.byType('AlertDialog');
      final btnLogin = find.byValueKey('btn_login');
      final btnRegister = find.byValueKey('btn_register');

      await driver.waitFor(btnLogin);
      await takeScreenshot(driver, 'login-page');
      await driver.tap(btnLogin);

      // Tunggu hingga dialog muncul
      try {
        await driver.waitFor(dialog, timeout: const Duration(seconds: 3));
        await takeScreenshot(driver, 'register-dialog');
        print('Dialog detected. Tapping Register button.');
        await driver.tap(btnRegister);
      } catch (e) {
        print('Dialog not detected. Skipping Register button.');
      }
    });

    test('Check Detail Product', () async {
      final productItem = find.byValueKey('product_item_1');
      await driver.waitFor(productItem);
      await driver.tap(productItem);
      await takeScreenshot(driver, 'product-detail');
      expect(productItem, isNotNull, reason: 'Product item not found!');
    });
  });
}
