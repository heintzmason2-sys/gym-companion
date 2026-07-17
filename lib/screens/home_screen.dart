import 'package:flutter/material.dart';
import 'home_setup_screen.dart' as home_setup;
import '../widgets/dashboard_cards.dart' as dashboard_cards;

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
    builder: (context) => const home_setup.HomeSetupScreen(),
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
                  child: dashboard_cards.buildStatCard(
                    'Protein',
                    '165g',
                    Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: dashboard_cards.buildStatCard(
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
