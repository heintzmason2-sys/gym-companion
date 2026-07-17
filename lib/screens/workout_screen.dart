import 'package:flutter/material.dart';
import 'exercise_log_screen.dart' as exercise_log;

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView(
          children: [

            _buildWorkoutCard(
              context,
              'Push Day',
              'Chest • Shoulders • Triceps',
              Icons.fitness_center,
            ),

            const SizedBox(height: 20),

            _buildWorkoutCard(
              context,
              'Pull Day',
              'Back • Biceps',
              Icons.sports_gymnastics,
            ),

            const SizedBox(height: 20),

            _buildWorkoutCard(
              context,
              'Leg Day',
              'Quads • Hamstrings • Calves',
              Icons.directions_run,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildWorkoutCard(
  BuildContext context,
  String title,
  String subtitle,
  IconData icon,
) {

  return GestureDetector(
    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (context) => WorkoutDetailScreen(
            workoutTitle: title,
          ),
        ),
      );
    },

    child: Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            size: 50,
            color: Colors.greenAccent,
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class WorkoutDetailScreen extends StatelessWidget {

  final String workoutTitle;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutTitle,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutTitle),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Exercises',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ..._getExercisesForWorkout(
              context,
              workoutTitle,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildExerciseTile(
  BuildContext context,
  String exerciseName,
) {

  return GestureDetector(
    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (context) => exercise_log.ExerciseLogScreen(
            exerciseName: exerciseName,
          ),
        ),
      );
    },

    child: Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            exerciseName,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),

          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}

List<Widget> _getExercisesForWorkout(
  BuildContext context,
  String workoutTitle,
) {

  if (workoutTitle == 'Push Day') {

    return [
      _buildExerciseTile(context, 'Bench Press'),
      _buildExerciseTile(context, 'Incline Dumbbell Press'),
      _buildExerciseTile(context, 'Shoulder Press'),
      _buildExerciseTile(context, 'Lateral Raises'),
      _buildExerciseTile(context, 'Tricep Pushdowns'),
    ];
  }

  else if (workoutTitle == 'Pull Day') {

    return [
      _buildExerciseTile(context, 'Pull Ups'),
      _buildExerciseTile(context, 'Barbell Rows'),
      _buildExerciseTile(context, 'Lat Pulldowns'),
      _buildExerciseTile(context, 'Seated Cable Rows'),
      _buildExerciseTile(context, 'Barbell Curls'),
    ];
  }

  else {

    return [
      _buildExerciseTile(context, 'Squats'),
      _buildExerciseTile(context, 'Leg Press'),
      _buildExerciseTile(context, 'Romanian Deadlifts'),
      _buildExerciseTile(context, 'Leg Curls'),
      _buildExerciseTile(context, 'Calf Raises'),
    ];
  }
}