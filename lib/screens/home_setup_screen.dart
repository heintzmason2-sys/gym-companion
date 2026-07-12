import 'package:flutter/material.dart';
import 'program_results_screen.dart';


class HomeSetupScreen extends StatefulWidget {
  const HomeSetupScreen({super.key});


@override
  State<HomeSetupScreen> createState() => _HomeSetupScreenState();
}
class _HomeSetupScreenState extends State<HomeSetupScreen> {
  String? selectedEquipment;
  String? selectedExperience;
  String? selectedGoal;
  String? selectedTrainingDays;
  int currentQuestion = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Program Setup'),
      ),
      body: Padding(
  padding: const EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [

     const SizedBox(height: 20),

      Text(
        'Question $currentQuestion of 4',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),

      SizedBox(height: 20),

      Text(
  currentQuestion == 1
      ? 'What equipment do you have?'
      : currentQuestion == 2
          ? 'What is your experience level?'
          : currentQuestion == 3
              ? 'What is your training goal?'
              : 'How many days per week can you train?',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      
      RadioListTile<String>(
  title: Text(
    currentQuestion == 1
        ? 'No Equipment'
        : currentQuestion == 2
            ? 'Beginner'
            : currentQuestion == 3
                ? 'Build Muscle'
                : '3 Days',
  ),
  value: currentQuestion == 1
      ? 'No Equipment'
      : currentQuestion == 2
          ? 'Beginner'
          : currentQuestion == 3
              ? 'Build Muscle'
              : '3 Days',
  groupValue: currentQuestion == 1
      ? selectedEquipment
      : currentQuestion == 2
          ? selectedExperience
          : currentQuestion == 3
              ? selectedGoal
              : selectedTrainingDays,
  onChanged: (value) {
    setState(() {
      if (currentQuestion == 1) {
        selectedEquipment = value;
      } else if (currentQuestion == 2) {
        selectedExperience = value;
      } else if (currentQuestion == 3) {
        selectedGoal = value;
      } else {
        selectedTrainingDays = value;
      }
    });
  },
),


   RadioListTile<String>(
  title: Text(
    currentQuestion == 1
        ? 'Resistance Bands'
        : currentQuestion == 2
            ? 'Intermediate'
            : currentQuestion == 3
                ? 'Get Stronger'
                : '4 Days',
  ),
  value: currentQuestion == 1
      ? 'Resistance Bands'
      : currentQuestion == 2
          ? 'Intermediate'
          : currentQuestion == 3
              ? 'Get Stronger'
              : '4 Days',
  groupValue: currentQuestion == 1
      ? selectedEquipment
      : currentQuestion == 2
          ? selectedExperience
          : currentQuestion == 3
              ? selectedGoal
              : selectedTrainingDays,
  onChanged: (value) {
    setState(() {
      if (currentQuestion == 1) {
        selectedEquipment = value;
      } else if (currentQuestion == 2) {
        selectedExperience = value;
      } else if (currentQuestion == 3) {
        selectedGoal = value;
      } else {
        selectedTrainingDays = value;
      }
    });
  },
),


RadioListTile<String>(
  title: Text(
    currentQuestion == 1
        ? 'Weights & Machines'
        : currentQuestion == 2
            ? 'Advanced'
            : currentQuestion == 3
                ? 'General Fitness'
                : '5–6 Days',
  ),
  value: currentQuestion == 1
      ? 'Weights & Machines'
      : currentQuestion == 2
          ? 'Advanced'
          : currentQuestion == 3
              ? 'General Fitness'
              : '5–6 Days',
  groupValue: currentQuestion == 1
      ? selectedEquipment
      : currentQuestion == 2
          ? selectedExperience
          : currentQuestion == 3
              ? selectedGoal
              : selectedTrainingDays,
  onChanged: (value) {
    setState(() {
      if (currentQuestion == 1) {
        selectedEquipment = value;
      } else if (currentQuestion == 2) {
        selectedExperience = value;
      } else if (currentQuestion == 3) {
        selectedGoal = value;
      } else {
        selectedTrainingDays = value;
      }
    });
  },
),

const SizedBox(height: 30),

ElevatedButton(
  onPressed: () {
    if (currentQuestion == 1 && selectedEquipment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select your equipment before continuing.',
          ),
        ),
      );
      return;
    }

    if (currentQuestion == 2 && selectedExperience == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select your experience level before continuing.',
          ),
        ),
      );
      return;
    }

    if (currentQuestion == 3 && selectedGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select your training goal before continuing.',
          ),
        ),
      );
      return;
    }

    if (currentQuestion == 4 && selectedTrainingDays == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select your training days before continuing.',
          ),
        ),
      );
      return;
    }

    if (currentQuestion < 4) {
  setState(() {
    currentQuestion++;
  });
} else {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProgramResultsScreen(
  equipment: selectedEquipment,
  experience: selectedExperience,
  goal: selectedGoal,
  trainingDays: selectedTrainingDays,
),
    ),
  );
}
  },
  child: Text(
  currentQuestion == 4 ? 'Create Program' : 'Continue',
),
),
      ],
    ),
  ),
);
  }
}
