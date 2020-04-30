// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

//import 'package:flutter/material.dart';
//import 'package:flutter_check_hub/service/date_time.dart';
import 'package:flutter_check_hub/service/datebase_key.dart';
import 'package:flutter_test/flutter_test.dart';

//import 'package:flutter_check_hub/main.dart';

void main() {
  test('daytime2int', () {
    final databaseKey = DatabaseKey();
    final int value = databaseKey.datetimetKeyFormatter(DateTime(2020, 4, 30));
    expect(value, 20200430);
  });

  /*
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CheckHub());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  */
}
