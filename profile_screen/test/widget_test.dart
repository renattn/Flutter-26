// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:profile_screen/main.dart';

void main() {
  testWidgets('reactive screen has its three components', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tap this card'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
  });
}
