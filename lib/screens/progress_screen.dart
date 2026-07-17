import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/dashboard_cards.dart' as dashboard_cards;

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

            dashboard_cards.buildAnalyticsCard(
              'Total Sets Logged',
              '$totalSets',
              Icons.format_list_numbered,
            ),

            const SizedBox(height: 20),

            dashboard_cards.buildAnalyticsCard(
              'Highest Personal Record',
              '$highestPR lbs',
              Icons.emoji_events,
            ),

            const SizedBox(height: 20),

            dashboard_cards.buildAnalyticsCard(
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