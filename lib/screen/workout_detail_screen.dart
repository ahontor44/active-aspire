import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final workoutIndex = Provider.of<HomeScreenModel>(context)
        .items
        .indexWhere((item) => item["title"] == workout);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Workout Details'),
      ),
      body: Consumer<HomeScreenModel>(
        builder: (context, model, child) {
          final exercises = model.items[workoutIndex]["exercises"];
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return ListTile(
                      title: Text('${exercise['name']}'),
                      subtitle: Text('Sets: ${exercise['sets']}, Reps: ${exercise['reps']}'),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String result) {
                          if (result == 'Edit') {
                            _showEditExerciseDialog(context, model, workoutIndex, index);
                          } else if (result == 'Delete') {
                            model.deleteExercise(workoutIndex, index);
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showAddExerciseDialog(context, model, workoutIndex);
                  },
                  child: Text('Add Exercise'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context, HomeScreenModel model, int workoutIndex) {
    final TextEditingController exerciseController = TextEditingController();
    final TextEditingController setsController = TextEditingController();
    final TextEditingController repsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                decoration: InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: setsController,
                decoration: InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: repsController,
                decoration: InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                model.addExercise(workoutIndex, {
                  'name': exerciseController.text,
                  'sets': int.tryParse(setsController.text) ?? 0,
                  'reps': int.tryParse(repsController.text) ?? 0,
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditExerciseDialog(BuildContext context, HomeScreenModel model, int workoutIndex, int exerciseIndex) {
    final exercise = model.items[workoutIndex]["exercises"][exerciseIndex];
    final TextEditingController exerciseController = TextEditingController(text: exercise['name']);
    final TextEditingController setsController = TextEditingController(text: exercise['sets'].toString());
    final TextEditingController repsController = TextEditingController(text: exercise['reps'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                decoration: InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: setsController,
                decoration: InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: repsController,
                decoration: InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                model.updateExercise(workoutIndex, exerciseIndex, {
                  'name': exerciseController.text,
                  'sets': int.tryParse(setsController.text) ?? 0,
                  'reps': int.tryParse(repsController.text) ?? 0,
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
