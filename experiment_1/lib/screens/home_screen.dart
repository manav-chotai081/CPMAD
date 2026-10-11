import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Lab Calculators')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select an experiment',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/student'),
              child: const Text('Student Result Calculator'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/employee'),
              child: const Text('Employee Salary Calculator'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/electricity'),
              child: const Text('Electricity Bill Calculator'),
            ),
          ],
        ),
      ),
    );
  }
}
