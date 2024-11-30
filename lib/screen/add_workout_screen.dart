import 'package:flutter/material.dart';

class AddWorkoutDialog extends StatefulWidget {
  final Function(String, List<Map<String, dynamic>>) onAddWorkout;
  final String? existingWorkout;
  final List<Map<String, dynamic>>? existingExercises;

  const AddWorkoutDialog({
    super.key,
    required this.onAddWorkout,
    this.existingWorkout,
    this.existingExercises,
  });

  @override
  _AddWorkoutDialogState createState() => _AddWorkoutDialogState();
}

class _AddWorkoutDialogState extends State<AddWorkoutDialog> {
  final TextEditingController _workoutController = TextEditingController();
  List<Map<String, dynamic>> _exercises = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingWorkout != null) {
      _workoutController.text = widget.existingWorkout!;
    }
    if (widget.existingExercises != null) {
      _exercises = List.from(widget.existingExercises!);
    }
  }

  void _addExerciseDialog() {
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
                setState(() {
                  _exercises.add({
                    'name': exerciseController.text,
                    'sets': int.tryParse(setsController.text) ?? 0,
                    'reps': int.tryParse(repsController.text) ?? 0,
                  });
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

  void _editExerciseDialog(int index) {
    final TextEditingController exerciseController = TextEditingController(text: _exercises[index]['name']);
    final TextEditingController setsController = TextEditingController(text: _exercises[index]['sets'].toString());
    final TextEditingController repsController = TextEditingController(text: _exercises[index]['reps'].toString());

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
                setState(() {
                  _exercises[index] = {
                    'name': exerciseController.text,
                    'sets': int.tryParse(setsController.text) ?? 0,
                    'reps': int.tryParse(repsController.text) ?? 0,
                  };
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existingWorkout == null ? 'Add Workout' : 'Edit Workout'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _workoutController,
            decoration: const InputDecoration(labelText: 'Workout Name'),
          ),
          ElevatedButton(
            onPressed: _addExerciseDialog,
            child: Text('Add Exercise'),
          ),
          ..._exercises.map((exercise) {
            int index = _exercises.indexOf(exercise);
            return ListTile(
              title: Text('${exercise['name']} - Sets: ${exercise['sets']}, Reps: ${exercise['reps']}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editExerciseDialog(index);
                },
              ),
            );
          }),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAddWorkout(_workoutController.text, _exercises);
            Navigator.pop(context);
          },
          child: Text(widget.existingWorkout == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
