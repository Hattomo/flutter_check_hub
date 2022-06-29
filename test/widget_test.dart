// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_check_hub/service/datebase_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    test('daytime2int', () {
    final DatabaseKey databaseKey = DatabaseKey();
    final String value =
        databaseKey.datetimetKeyFormatter(DateTime(2020, 4, 30)).toString();
    expect(value, '20200430');
  });
}
