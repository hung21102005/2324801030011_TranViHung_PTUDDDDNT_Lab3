// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab3_navigator/main.dart';

void main() {
  testWidgets('Socially app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const SociallyApp());

    expect(find.text('Socially'), findsOneWidget);
  });

  testWidgets('Tapping 3-lines menu opens Drawer', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const SociallyApp());

    // Tap the hamburger menu icon
    await tester.tap(find.byTooltip('Open Drawer').first);
    await tester.pumpAndSettle();

    // Verify Drawer is opened and shows user details and menu
    expect(find.textContaining('Tran Vi Hung'), findsWidgets);
    expect(find.text('Categories & Topics'), findsOneWidget);
    expect(find.text('Saved Posts'), findsOneWidget);
    expect(find.text('Flutter Drawer Contract'), findsOneWidget);
  });

  testWidgets(
      'Tapping My Profile in Drawer and then back arrow navigates safely without black screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const SociallyApp());

    // 1. Open drawer
    await tester.tap(find.byTooltip('Open Drawer').first);
    await tester.pumpAndSettle();

    // 2. Tap My Profile menu item
    await tester.tap(find.text('My Profile'));
    await tester.pumpAndSettle();

    // 3. Verify we are on Profile screen
    expect(find.text('Profile'), findsWidgets);
    expect(find.text('Edit Profile'), findsOneWidget);

    // 4. Tap the back arrow on Profile screen
    await tester.tap(find.byTooltip('Back to Home Feed'));
    await tester.pumpAndSettle();

    // 5. Verify we are back on Home Feed, NOT a black/empty screen
    expect(find.text('Socially'), findsOneWidget);
    expect(find.text('Create Post'), findsOneWidget);
  });
}
