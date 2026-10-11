import 'package:flutter/material.dart';

class ElectricityBillScreen extends StatefulWidget {
  const ElectricityBillScreen({super.key});

  @override
  State<ElectricityBillScreen> createState() => _ElectricityBillScreenState();
}

class _ElectricityBillScreenState extends State<ElectricityBillScreen> {
  final _unitsController = TextEditingController();
  String? _errorMessage;
  int? _units;
  double? _firstSlabCharge;
  double? _secondSlabCharge;
  double? _aboveSlabCharge;

  @override
  void dispose() {
    _unitsController.dispose();
    super.dispose();
  }

  void _calculateBill() {
    final units = int.tryParse(_unitsController.text.trim());
    if (units == null || units < 0) {
      setState(() => _errorMessage = 'Enter a valid number of units.');
      return;
    }

    final firstSlabUnits = units > 100 ? 100 : units;
    final secondSlabUnits = units > 100 ? (units > 200 ? 100 : units - 100) : 0;
    final aboveSlabUnits = units > 200 ? units - 200 : 0;

    setState(() {
      _errorMessage = null;
      _units = units;
      _firstSlabCharge = firstSlabUnits * 2;
      _secondSlabCharge = secondSlabUnits * 3;
      _aboveSlabCharge = aboveSlabUnits * 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total =
        _firstSlabCharge != null &&
            _secondSlabCharge != null &&
            _aboveSlabCharge != null
        ? _firstSlabCharge! + _secondSlabCharge! + _aboveSlabCharge!
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Electricity Bill Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Units consumed',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Rates: first 100 units ₹2, next 100 units ₹3, above 200 ₹5',
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _calculateBill,
              child: const Text('Calculate Bill'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            if (total != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Bill Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Units consumed: $_units'),
              Text(
                'First 100 units charge: ₹${_firstSlabCharge!.toStringAsFixed(2)}',
              ),
              Text(
                'Next 100 units charge: ₹${_secondSlabCharge!.toStringAsFixed(2)}',
              ),
              Text(
                'Above 200 units charge: ₹${_aboveSlabCharge!.toStringAsFixed(2)}',
              ),
              Text('Total Bill: ₹${total.toStringAsFixed(2)}'),
            ],
          ],
        ),
      ),
    );
  }
}
