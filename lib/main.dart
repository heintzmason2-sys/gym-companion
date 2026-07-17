import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/settings_screen.dart' as settings;
import 'screens/nutrition_screen.dart' as nutrition;
import 'screens/calculator_screen.dart' as calculator;
import 'screens/progress_screen.dart' as progress;
import 'screens/home_screen.dart' as home;
import 'screens/exercise_log_screen.dart' as exercise_log;
import 'screens/workout_screen.dart' as workout;

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
    const home.HomeScreen(),
    const workout.WorkoutScreen(),
    const nutrition.NutritionScreen(),
    const progress.ProgressScreen(),
    const calculator.CalculatorScreen(),
    const settings.SettingsScreen(),
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



