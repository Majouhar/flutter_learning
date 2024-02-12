import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:go_moon/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end to end app-test', () {
    var weightIncrementBtn = find.byKey(
      const Key("weight_add"),
    );
    var ageIncrementBtn = find.byKey(
      const Key("age_add"),
    );
    var calculateBtn = find.byType(CupertinoButton);

    testWidgets(
        "Given app is ran when height and weight and age data input and calculateEmi button passed",
        (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(weightIncrementBtn);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(ageIncrementBtn);
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(calculateBtn);
      await widgetTester.pumpAndSettle();
      final resultText = find.text('Normal');
      expect(resultText, findsOneWidget);
    });
  });
}
