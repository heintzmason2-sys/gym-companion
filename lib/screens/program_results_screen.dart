import 'package:flutter/material.dart';

class ProgramResultsScreen extends StatelessWidget {
  final String? equipment;
  final String? experience;
  final String? goal;
  final String? trainingDays;

  const ProgramResultsScreen({
    super.key,
    this.equipment,
    this.experience,
    this.goal,
    this.trainingDays,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Program'),
      ),
      body: Center(
        child: Text(
          'Equipment: $equipment',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}