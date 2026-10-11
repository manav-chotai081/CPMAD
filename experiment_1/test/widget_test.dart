import 'package:flutter_test/flutter_test.dart';

import 'package:experiment_1/main.dart';

void main() {
  testWidgets('calculator menu shows all experiments', (tester) async {
    await tester.pumpWidget(const CalculatorApp());

    expect(find.text('Student Result Calculator'), findsOneWidget);
    expect(find.text('Employee Salary Calculator'), findsOneWidget);
    expect(find.text('Electricity Bill Calculator'), findsOneWidget);
  });
}
