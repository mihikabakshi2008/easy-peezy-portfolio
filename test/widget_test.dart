import 'package:flutter_test/flutter_test.dart';
import 'package:easy_peezy/main.dart';

void main() {
  testWidgets('Easy Peezy app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const EasyPeezyApp());

    expect(find.text('Easy Peezy'), findsWidgets);
  });
}