// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:OpenBreath/main.dart';
import 'package:OpenBreath/data.dart';

void main() {
  testWidgets('BreathingExerciseScreen displays exercises', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const OpenBreathApp());

    // Verify that the PageView is displayed.
    expect(find.byType(PageView), findsOneWidget);

    // Verify that the number of exercises matches the expected count.
    expect(breathingExercises.length, 5); // 3 original + 2 new = 5
  });
}
