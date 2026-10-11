import 'package:flutter/material.dart';

class Student {
  Student({required this.name, required this.marks});

  final String name;
  final Map<String, double> marks;

  double get totalMarks =>
      marks.values.fold(0, (total, subjectMarks) => total + subjectMarks);

  double get percentage => totalMarks / marks.length;

  bool get isPassed =>
      marks.values.every((subjectMarks) => subjectMarks >= 35);

  String get grade {
    if (!isPassed) {
      return 'F';
    }
    if (percentage >= 90) {
      return 'A+';
    }
    if (percentage >= 80) {
      return 'A';
    }
    if (percentage >= 70) {
      return 'B';
    }
    if (percentage >= 60) {
      return 'C';
    }
    if (percentage >= 50) {
      return 'D';
    }
    return 'E';
  }
}

class StudentResultScreen extends StatefulWidget {
  const StudentResultScreen({super.key});

  @override
  State<StudentResultScreen> createState() => _StudentResultScreenState();
}

class _StudentResultScreenState extends State<StudentResultScreen> {
  final _nameController = TextEditingController();
  final _markControllers =
      List.generate(5, (index) => TextEditingController());
  final List<String> _subjects = [
    'English',
    'Mathematics',
    'Science',
    'Social Studies',
    'Computer',
  ];

  Student? _student;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    for (final controller in _markControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _calculateResult() async {
    final name = _nameController.text.trim();
    final marks = <String, double>{};

    if (name.isEmpty) {
      setState(() => _errorMessage = 'Please enter the student name.');
      return;
    }

    for (var index = 0; index < _subjects.length; index++) {
      final mark = double.tryParse(_markControllers[index].text.trim());
      if (mark == null || mark < 0 || mark > 100) {
        setState(() {
          _errorMessage = 'Enter marks from 0 to 100 for every subject.';
        });
        return;
      }
      marks[_subjects[index]] = mark;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) {
      return;
    }
    setState(() {
      _student = Student(name: name, marks: marks);
      _isLoading = false;
    });
  }

  Widget _numberField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: '$label marks',
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = _student;
    return Scaffold(
      appBar: AppBar(title: const Text('Student Result Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Student name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < _subjects.length; index++) ...[
              _numberField(_subjects[index], _markControllers[index]),
              const SizedBox(height: 12),
            ],
            ElevatedButton(
              onPressed: _isLoading ? null : _calculateResult,
              child: Text(_isLoading ? 'Loading...' : 'Calculate Result'),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            if (student != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Name: ${student.name}'),
              Text('Total Marks: ${student.totalMarks.toStringAsFixed(1)}'),
              Text('Percentage: ${student.percentage.toStringAsFixed(2)}%'),
              Text('Grade: ${student.grade}'),
              Text('Status: ${student.isPassed ? 'Pass' : 'Fail'}'),
            ],
          ],
        ),
      ),
    );
  }
}
