import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('workoutBox');

  runApp(const GymCompanionApp());
}

class GymCompanionApp extends StatelessWidget {
  const GymCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Companion',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WorkoutScreen(),
    const NutritionScreen(),
    const ProgressScreen(),
    const CalculatorScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Nutrition',
          ),

          BottomNavigationBarItem(
  icon: Icon(Icons.show_chart),
  label: 'Progress',
),

BottomNavigationBarItem(
  icon: Icon(Icons.calculate),
  label: 'Calculator',
),

BottomNavigationBarItem(
  icon: Icon(Icons.settings),
  label: 'Settings',
),
                ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Companion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back 💪',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.greenAccent, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🏋️ Today’s Program',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Not started yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Let’s build your workout path based on where you train.',
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
  showModalBottomSheet(
  context: context,
  builder: (context) {
    return SizedBox(
  height: 260,
  child: Column(
    children: [
      SizedBox(height: 20),

      Text(
        'Where are you training?',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 20),

      ListTile(
        leading: Text('🏠'),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const HomeSetupScreen(),
  ),
);
        },
        title: Text('Home'),
      ),

      ListTile(
        leading: Text('🏋️'),
        onTap: () {
          Navigator.pop(context);
        },
        title: Text('Gym'),
      ),

      ListTile(
        leading: Text('🌳'),
        onTap: () {
          Navigator.pop(context);
        },
        title: Text('Outside'),
      ),
    ],
  ),
);
  },
);
},
                    child: const Text('Choose Your Program'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Calories', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text(
                    '2,150 / 2,800',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Protein',
                    '165g',
                    Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(
                    'Water',
                    '3.2L',
                    Icons.water_drop,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today’s Workout',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text('Push Day', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text('Bench Press'),
                    Text('Shoulder Press'),
                    Text('Tricep Pushdowns'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeSetupScreen extends StatefulWidget {
  const HomeSetupScreen({super.key});


@override
  State<HomeSetupScreen> createState() => _HomeSetupScreenState();
}
class _HomeSetupScreenState extends State<HomeSetupScreen> {
  String? selectedEquipment;

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
        'Question 1 of 4',
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),

      SizedBox(height: 20),

      Text(
        'What equipment do you have?',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      RadioListTile<String>(
  title: const Text('None'),
  value: 'None',
  groupValue: selectedEquipment,
  onChanged: (value) {
    setState(() {
      selectedEquipment = value;
    });
    }
      ),

   RadioListTile<String>(
  title: const Text('Resistance Bands'),
  value: 'Resistance Bands',
  groupValue: selectedEquipment,
  onChanged: (value) {
    setState(() {
      selectedEquipment = value;
    });
    }
),
RadioListTile<String>(
  title: const Text('Dumbbells'),
  value: 'Dumbbells',
  groupValue: selectedEquipment,
  onChanged: (value) {
    setState(() {
      selectedEquipment = value;
    });
    }
    
),

const SizedBox(height: 30),

ElevatedButton(
  onPressed: () {
    print(selectedEquipment);
  },
  child: const Text('Continue'),
),
    ],
  ),
),
    );
  }
}  

      
Widget _buildStatCard(
  String title,
  String value,
  IconData icon,
) {

  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
    ),

    child: Column(
      children: [

        Icon(icon, size: 40),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnalyticsCard(
  String title,
  String value,
  IconData icon,
) {

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
    ),

    child: Row(
      children: [

        Icon(
          icon,
          size: 40,
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
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

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
          builder: (context) => ExerciseLogScreen(
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

class ExerciseLogScreen extends StatefulWidget {

  final String exerciseName;

  const ExerciseLogScreen({
    super.key,
    required this.exerciseName,
  });

  @override
  State<ExerciseLogScreen> createState() =>
      _ExerciseLogScreenState();
}

class _ExerciseLogScreenState
    extends State<ExerciseLogScreen> {

  final TextEditingController weightController =
      TextEditingController();

  final TextEditingController repsController =
      TextEditingController();

  List<String> loggedSets = [];

  int personalRecord = 0;

  @override
  void initState() {
    super.initState();

    final box = Hive.box('workoutBox');

    final savedSets =
        box.get(widget.exerciseName);

    if (savedSets != null) {

      setState(() {

        loggedSets =
            List<String>.from(savedSets);

        for (var set in loggedSets) {

          final weight =
              int.tryParse(
                set.split(' lbs')[0],
              ) ?? 0;

          if (weight > personalRecord) {

            personalRecord = weight;
          }
        }
      });
    }
  }

  void saveSet() {

    final box = Hive.box('workoutBox');

    final String weight =
        weightController.text;

    final String reps =
        repsController.text;

    if (weight.isEmpty || reps.isEmpty) {
      return;
    }

    setState(() {

      final newSet =
          '$weight lbs × $reps reps';

      final timestamp =
    DateTime.now();

final formattedSet =
    '$newSet\n'
    '${timestamp.month}/'
    '${timestamp.day}/'
    '${timestamp.year} - '
    '${timestamp.hour}:'
    '${timestamp.minute.toString().padLeft(2, '0')}';

loggedSets.add(
  formattedSet,
);

      final weightValue =
          int.tryParse(weight) ?? 0;

      if (weightValue > personalRecord) {

        personalRecord = weightValue;
      }

      box.put(
        widget.exerciseName,
        loggedSets,
      );

      weightController.clear();
      repsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseName),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Log Your Set',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: weightController,
              keyboardType:
                  TextInputType.number,

              decoration: InputDecoration(
                labelText: 'Weight',

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: repsController,
              keyboardType:
                  TextInputType.number,

              decoration: InputDecoration(
                labelText: 'Reps',

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: saveSet,

                child: const Text(
                  'Save Set',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Personal Record: $personalRecord lbs',

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Logged Sets',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount:
                    loggedSets.length,

                itemBuilder:
                    (context, index) {

                  return Container(
                    margin:
                        const EdgeInsets.only(
                            bottom: 15),

                    padding:
                        const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.grey[900],

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        Expanded(
                          child: Text(
                            loggedSets[index],

                            style:
                                const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),

                          onPressed: () {

                            final parts =
                                loggedSets[index]
                                    .split(
                                        ' lbs × ');

                            final currentWeight =
                                parts[0];

                            final currentReps =
                                parts[1]
                                    .replaceAll(
                                        ' reps',
                                        '');

                            final editWeightController =
                                TextEditingController(
                              text:
                                  currentWeight,
                            );

                            final editRepsController =
                                TextEditingController(
                              text:
                                  currentReps,
                            );

                            showDialog(
                              context: context,

                              builder:
                                  (context) {

                                return AlertDialog(

                                  title:
                                      const Text(
                                    'Edit Set',
                                  ),

                                  content:
                                      Column(
                                    mainAxisSize:
                                        MainAxisSize
                                            .min,

                                    children: [

                                      TextField(
                                        controller:
                                            editWeightController,

                                        keyboardType:
                                            TextInputType
                                                .number,

                                        decoration:
                                            const InputDecoration(
                                          labelText:
                                              'Weight',
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              20),

                                      TextField(
                                        controller:
                                            editRepsController,

                                        keyboardType:
                                            TextInputType
                                                .number,

                                        decoration:
                                            const InputDecoration(
                                          labelText:
                                              'Reps',
                                        ),
                                      ),
                                    ],
                                  ),

                                  actions: [

                                    TextButton(
                                      onPressed:
                                          () {

                                        Navigator.pop(
                                            context);
                                      },

                                      child:
                                          const Text(
                                        'Cancel',
                                      ),
                                    ),

                                    ElevatedButton(
                                      onPressed:
                                          () {

                                        final updatedSet =
                                            '${editWeightController.text} lbs × ${editRepsController.text} reps';

                                        setState(
                                            () {

                                          loggedSets[
                                                  index] =
                                              updatedSet;

                                          personalRecord =
                                              0;

                                          for (var set
                                              in loggedSets) {

                                            final weight =
                                                int.tryParse(
                                                      set.split(
                                                          ' lbs')[0],
                                                    ) ??
                                                    0;

                                            if (weight >
                                                personalRecord) {

                                              personalRecord =
                                                  weight;
                                            }
                                          }

                                          final box =
                                              Hive.box(
                                                  'workoutBox');

                                          box.put(
                                            widget.exerciseName,
                                            loggedSets,
                                          );
                                        });

                                        Navigator.pop(
                                            context);
                                      },

                                      child:
                                          const Text(
                                        'Save',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),

                          onPressed: () {

                            setState(() {

                              loggedSets
                                  .removeAt(index);

                              personalRecord = 0;

                              for (var set
                                  in loggedSets) {

                                final weight =
                                    int.tryParse(
                                          set.split(
                                              ' lbs')[0],
                                        ) ??
                                        0;

                                if (weight >
                                    personalRecord) {

                                  personalRecord =
                                      weight;
                                }
                              }

                              final box =
                                  Hive.box(
                                      'workoutBox');

                              box.put(
                                widget.exerciseName,
                                loggedSets,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Nutrition Tracker',
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() =>
      _ProgressScreenState();
}

class _ProgressScreenState
    extends State<ProgressScreen> {

  String selectedExercise =
      'Bench Press';

  final List<String> exercises = [

    // Push Day
    'Bench Press',
    'Incline Dumbbell Press',
    'Shoulder Press',
    'Lateral Raises',
    'Tricep Pushdowns',

    // Pull Day
    'Pull Ups',
    'Barbell Rows',
    'Lat Pulldowns',
    'Seated Cable Rows',
    'Barbell Curls',

    // Leg Day
    'Squats',
    'Leg Press',
    'Romanian Deadlifts',
    'Leg Curls',
    'Calf Raises',
  ];

  @override
  Widget build(BuildContext context) {

    final box = Hive.box('workoutBox');

    int totalSets = 0;
    int highestPR = 0;
    int totalVolume = 0;

    for (var key in box.keys) {

      final sets =
          List<String>.from(
              box.get(key));

      totalSets += sets.length;

      for (var set in sets) {

        final parts =
            set.split(' lbs × ');

        final weight =
            int.tryParse(parts[0]) ?? 0;

        final reps =
            int.tryParse(
              parts[1]
                  .replaceAll(
                      ' reps',
                      ''),
            ) ?? 0;

        totalVolume +=
            weight * reps;

        if (weight > highestPR) {
          highestPR = weight;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Progress Analytics',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            _buildAnalyticsCard(
              'Total Sets Logged',
              '$totalSets',
              Icons.format_list_numbered,
            ),

            const SizedBox(height: 20),

            _buildAnalyticsCard(
              'Highest Personal Record',
              '$highestPR lbs',
              Icons.emoji_events,
            ),

            const SizedBox(height: 20),

            _buildAnalyticsCard(
              'Total Workout Volume',
              '$totalVolume lbs',
              Icons.bar_chart,
            ),

            const SizedBox(height: 30),

            DropdownButton<String>(
              value: selectedExercise,
              isExpanded: true,

              items:
                  exercises.map((exercise) {

                return DropdownMenuItem(
                  value: exercise,

                  child: Text(
                    exercise,
                  ),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  selectedExercise =
                      value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Text(
              '$selectedExercise Progress',

              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,

              child: LineChart(
                LineChartData(

                  gridData:
                      FlGridData(
                    show: true,
                  ),

                  borderData:
                      FlBorderData(
                    show: true,
                  ),

                  titlesData:
                      FlTitlesData(
                    show: true,
                  ),

                  lineBarsData: [

                    LineChartBarData(
                      isCurved: true,

                      spots: () {

                        final savedSets =
                            box.get(
                              selectedExercise,
                            );

                        if (savedSets ==
                            null) {

                          return <FlSpot>[];
                        }

                        List<FlSpot>
                            spots = [];

                        for (
                          int i = 0;
                          i <
                              savedSets
                                  .length;
                          i++
                        ) {

                          final set =
                              savedSets[
                                  i];

                          final weight =
                              int.tryParse(
                                    set.split(
                                        ' lbs')[0],
                                  ) ??
                                  0;

                          spots.add(

                            FlSpot(
                              i.toDouble(),
                              weight
                                  .toDouble(),
                            ),
                          );
                        }

                        return spots;

                      }(),

                      dotData:
                          FlDotData(
                        show: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'TODAY',

              style: TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
                color:
                    Colors.greenAccent,
              ),
            ),

            const SizedBox(height: 20),

            ...box.keys.map((key) {

              final sets =
                  List<String>.from(
                      box.get(key));

              sets.sort(
                (a, b) =>
                    b.compareTo(a),
              );

              final today =
                  '${DateTime.now().month}/'
                  '${DateTime.now().day}/'
                  '${DateTime.now().year}';

              final todaySets =
                  sets.where((set) {

                return set.contains(
                    today);

              }).toList();

              final yesterday =
                  DateTime.now()
                      .subtract(
                const Duration(
                    days: 1),
              );

              final yesterdayDate =
                  '${yesterday.month}/'
                  '${yesterday.day}/'
                  '${yesterday.year}';

              final yesterdaySets =
                  sets.where((set) {

                return set.contains(
                    yesterdayDate);

              }).toList();

              return Container(
                margin:
                    const EdgeInsets.only(
                        bottom: 20),

                padding:
                    const EdgeInsets.all(
                        24),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.grey[850],

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      '$key Session',

                      style:
                          const TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    Container(
                      height: 2,
                      color:
                          Colors.white24,
                    ),

                    const SizedBox(
                        height: 16),

                    ...todaySets.map((set) {

                      return Padding(
                        padding:
                            const EdgeInsets
                                .only(
                                    bottom:
                                        8),

                        child: Text(
                          set.replaceAll(
                              '\n',
                              '\n🕒 '),

                          style:
                              const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );

                    }).toList(),

                    if (yesterdaySets
                        .isNotEmpty) ...[

                      const SizedBox(
                          height: 30),

                      const Text(
                        'YESTERDAY',

                        style:
                            TextStyle(
                          fontSize:
                              22,
                          fontWeight:
                              FontWeight
                                  .bold,
                          color:
                              Colors
                                  .orangeAccent,
                        ),
                      ),

                      const SizedBox(
                          height: 15),

                      ...yesterdaySets
                          .map((set) {

                        return Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                                      bottom:
                                          8),

                          child: Text(
                            set.replaceAll(
                                '\n',
                                '\n🕒 '),

                            style:
                                const TextStyle(
                              fontSize:
                                  18,
                            ),
                          ),
                        );

                      }).toList(),
                    ],
                  ],
                ),
              );

            }).toList(),
          ],
        ),
      ),
    );
  }
}

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
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Settings',
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}