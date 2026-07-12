import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchesController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String selectedGender = 'Male';
  String selectedActivity = 'Moderately Active';
  String selectedGoal = 'Build Muscle & Lose Fat';
  String calculatorResult = '';

  Widget _buildGoalCard({
    required String goal,
    required String emoji,
    required String description,
  }) {
    final bool isSelected = selectedGoal == goal;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGoal = goal;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.25) : Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.greenAccent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fitness Calculator',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const Text('Weight (lbs)'),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter weight',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text('Height'),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: feetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Feet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: inchesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Inches',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text('Age'),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Biological Sex',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'How active are you each week?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            DropdownButton<String>(
              value: selectedActivity,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Sedentary',
                  child: Text('Sedentary'),
                ),
                DropdownMenuItem(
                  value: 'Lightly Active',
                  child: Text('Lightly Active'),
                ),
                DropdownMenuItem(
                  value: 'Moderately Active',
                  child: Text('Moderately Active'),
                ),
                DropdownMenuItem(
                  value: 'Very Active',
                  child: Text('Very Active'),
                ),
                DropdownMenuItem(
                  value: 'Extremely Active',
                  child: Text('Extremely Active'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedActivity = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'What do you want to accomplish?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildGoalCard(
              goal: 'Lose Fat',
              emoji: '🔥',
              description: 'Reduce body fat while keeping muscle.',
            ),

            _buildGoalCard(
              goal: 'Build Muscle',
              emoji: '💪',
              description: 'Gain muscle with a small calorie surplus.',
            ),

            _buildGoalCard(
              goal: 'Build Muscle & Lose Fat',
              emoji: '⚖️',
              description: 'Recomp by training hard and eating near maintenance.',
            ),

            _buildGoalCard(
              goal: 'Maintain Weight',
              emoji: '❤️',
              description: 'Stay around your current weight and build habits.',
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                final weight = double.tryParse(weightController.text) ?? 0;
                final feet = double.tryParse(feetController.text) ?? 0;
                final inches = double.tryParse(inchesController.text) ?? 0;
                final age = double.tryParse(ageController.text) ?? 0;

                if (weight == 0 || feet == 0 || age == 0) {
                  setState(() {
                    calculatorResult = 'Please enter valid values';
                  });
                  return;
                }

                final totalInches = (feet * 12) + inches;
                final bmi = (weight / (totalInches * totalInches)) * 703;

                String category = '';

                if (bmi < 18.5) {
                  category = 'Underweight';
                } else if (bmi < 25) {
                  category = 'Healthy Weight';
                } else if (bmi < 30) {
                  category = 'Overweight';
                } else {
                  category = 'Obese';
                }

                final weightKg = weight * 0.453592;
                final heightCm = totalInches * 2.54;

                double bmr = 0;

                if (selectedGender == 'Male') {
                  bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
                } else {
                  bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
                }

                double multiplier = 1.55;

                if (selectedActivity == 'Sedentary') {
                  multiplier = 1.2;
                } else if (selectedActivity == 'Lightly Active') {
                  multiplier = 1.375;
                } else if (selectedActivity == 'Moderately Active') {
                  multiplier = 1.55;
                } else if (selectedActivity == 'Very Active') {
                  multiplier = 1.725;
                } else if (selectedActivity == 'Extremely Active') {
                  multiplier = 1.9;
                }

                final maintenance = bmr * multiplier;

                double recommendedCalories = maintenance;
                String goalTip = '';

                if (selectedGoal == 'Lose Fat') {
                  recommendedCalories = maintenance - 500;
                  goalTip = 'Aim to lose fat slowly while keeping protein high.';
                } else if (selectedGoal == 'Build Muscle') {
                  recommendedCalories = maintenance + 250;
                  goalTip = 'Use a small surplus to build muscle without gaining too much fat.';
                } else if (selectedGoal == 'Build Muscle & Lose Fat') {
                  recommendedCalories = maintenance - 100;
                  goalTip = 'Stay close to maintenance, lift hard, and keep protein high.';
                } else if (selectedGoal == 'Maintain Weight') {
                  recommendedCalories = maintenance;
                  goalTip = 'Stay consistent and focus on strength, habits, and health.';
                }

                setState(() {
                  calculatorResult =
                      'BMI: ${bmi.toStringAsFixed(1)}\n'
                      '$category\n\n'
                      'Goal: $selectedGoal\n'
                      'Recommended Calories: ${recommendedCalories.round()} kcal/day\n\n'
                      '$goalTip';
                });
              },
              child: const Text('Calculate'),
            ),

            const SizedBox(height: 25),

            Text(
              calculatorResult,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
