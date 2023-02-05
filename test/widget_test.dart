import 'package:flutter_test/flutter_test.dart';

import 'package:vakinha_app/app/vakinha_app.dart';

void main() {
  testWidgets('Should Renders VakinhaApp', (WidgetTester tester) async {
    await tester.pumpWidget(VakinhaApp());
    expect(find.byType(VakinhaApp), findsOneWidget);
  });
}
