import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_moon/pages/bmi_page.dart';

void main() {
  testWidgets('Given user click + button then increase the value',
      (tester) async {
    // TODO: Implement test
    await tester.pumpWidget(const CupertinoApp(
      home: BMIPage(),
    ));
    var weigtText = find.byKey(const Key("weight_txt"));
    var initialText = (weigtText.evaluate().single.widget as Text).data ;

    var incrementKey = find.byKey(const Key("weight_add"));
    await tester.tap(incrementKey);

    await tester.pump();
    var finalText = (weigtText.evaluate().single.widget as Text).data ;
    expect( int.parse(finalText!) - int.parse(initialText!) , 1);
  });
}
