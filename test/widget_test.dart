// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro/view/addTask.dart';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Pomodoro app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(createWidgetForTesting(child: AddTaskForm(oldTask: null)));

    expect(find.text('No tasks to complete.'), findsNothing);
    // expect(find.text('Press Add Task to add a new one!'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
  });
}
