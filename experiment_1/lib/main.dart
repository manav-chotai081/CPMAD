import 'package:flutter/material.dart';

import 'screens/electricity_bill_screen.dart';
import 'screens/employee_salary_screen.dart';
import 'screens/home_screen.dart';
import 'screens/student_result_screen.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab Calculators',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        '/student': (context) => const StudentResultScreen(),
        '/employee': (context) => const EmployeeSalaryScreen(),
        '/electricity': (context) => const ElectricityBillScreen(),
      },
    );
  }
}
