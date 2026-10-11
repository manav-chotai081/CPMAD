import 'package:flutter/material.dart';

class EmployeeSalaryScreen extends StatefulWidget {
  const EmployeeSalaryScreen({super.key});

  @override
  State<EmployeeSalaryScreen> createState() => _EmployeeSalaryScreenState();
}

class _EmployeeSalaryScreenState extends State<EmployeeSalaryScreen> {
  final _nameController = TextEditingController();
  final _basicController = TextEditingController();
  final _hraController = TextEditingController(text: '20');
  final _daController = TextEditingController(text: '10');
  final _pfController = TextEditingController(text: '12');
  String? _errorMessage;
  double? _basic;
  double? _hra;
  double? _da;
  double? _pf;

  @override
  void dispose() {
    _nameController.dispose();
    _basicController.dispose();
    _hraController.dispose();
    _daController.dispose();
    _pfController.dispose();
    super.dispose();
  }

  void _calculateSalary() {
    final basic = double.tryParse(_basicController.text.trim());
    final hraRate = double.tryParse(_hraController.text.trim());
    final daRate = double.tryParse(_daController.text.trim());
    final pfRate = double.tryParse(_pfController.text.trim());

    if (_nameController.text.trim().isEmpty ||
        basic == null ||
        hraRate == null ||
        daRate == null ||
        pfRate == null ||
        basic < 0 ||
        hraRate < 0 ||
        daRate < 0 ||
        pfRate < 0) {
      setState(
        () => _errorMessage = 'Enter valid employee and salary details.',
      );
      return;
    }

    setState(() {
      _errorMessage = null;
      _basic = basic;
      _hra = basic * hraRate / 100;
      _da = basic * daRate / 100;
      _pf = basic * pfRate / 100;
    });
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = const TextInputType.numberWithOptions(
      decimal: true,
    ),
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final basic = _basic;
    final hra = _hra;
    final da = _da;
    final pf = _pf;
    final gross = basic != null && hra != null && da != null
        ? basic + hra + da
        : null;
    final net = gross != null && pf != null ? gross - pf : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Salary Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _field(
              'Employee name',
              _nameController,
              keyboardType: TextInputType.text,
            ),
            _field('Basic salary', _basicController),
            _field('HRA rate (%)', _hraController),
            _field('DA rate (%)', _daController),
            _field('PF rate (%)', _pfController),
            ElevatedButton(
              onPressed: _calculateSalary,
              child: const Text('Calculate Salary'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            if (net != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Salary Breakdown',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Employee: ${_nameController.text.trim()}'),
              Text('Basic Salary: ₹${basic!.toStringAsFixed(2)}'),
              Text('HRA: ₹${hra!.toStringAsFixed(2)}'),
              Text('DA: ₹${da!.toStringAsFixed(2)}'),
              Text('Gross Salary: ₹${gross!.toStringAsFixed(2)}'),
              Text('PF Deduction: ₹${pf!.toStringAsFixed(2)}'),
              Text('Net Salary: ₹${net.toStringAsFixed(2)}'),
            ],
          ],
        ),
      ),
    );
  }
}
