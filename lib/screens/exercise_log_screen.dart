import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
