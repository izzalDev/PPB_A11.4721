import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  group('Ayamku Test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      // Directory('screenshots').deleteSync(recursive: true);
      Directory('screenshots').create(recursive: true);
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

    test('Screenshot initial state', () async {
      await takeScreenshot(driver, 'initial_page2');
    });
  });
}
