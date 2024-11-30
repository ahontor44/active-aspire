import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreenModel extends ChangeNotifier {
  List<Map<String, dynamic>> items = [
    {"title": "Running", "icon": Icons.directions_run, "exercises": <Map<String, dynamic>>[]},
    {"title": "Cycling", "icon": Icons.directions_bike, "exercises": <Map<String, dynamic>>[]},
    {"title": "Swimming", "icon": Icons.pool, "exercises": <Map<String, dynamic>>[]},
    {"title": "Yoga", "icon": Icons.self_improvement, "exercises": <Map<String, dynamic>>[]},
    {"title": "Weight Training", "icon": Icons.fitness_center, "exercises": <Map<String, dynamic>>[]},
  ];

  void addNewWorkout(String workoutName, List<Map<String, dynamic>> exercises) {
    items.add({
      "title": workoutName,
      "icon": Icons.fitness_center,
      "exercises": exercises,
    });
    notifyListeners();
    Fluttertoast.showToast(msg: "Workout added", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void updateWorkout(int index, String newTitle, List<Map<String, dynamic>> exercises) {
    items[index] = {
      "title": newTitle,
      "icon": items[index]["icon"],
      "exercises": exercises,
    };
    notifyListeners();
    Fluttertoast.showToast(msg: "Workout updated", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void deleteWorkout(int index) {
    items.removeAt(index);
    notifyListeners();
    Fluttertoast.showToast(msg: "Workout deleted", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void addExercise(int workoutIndex, Map<String, dynamic> exercise) {
    items[workoutIndex]["exercises"].add(exercise);
    notifyListeners();
    Fluttertoast.showToast(msg: "Exercise added", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void updateExercise(int workoutIndex, int exerciseIndex, Map<String, dynamic> updatedExercise) {
    items[workoutIndex]["exercises"][exerciseIndex] = updatedExercise;
    notifyListeners();
    Fluttertoast.showToast(msg: "Exercise updated", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  void deleteExercise(int workoutIndex, int exerciseIndex) {
    items[workoutIndex]["exercises"].removeAt(exerciseIndex);
    notifyListeners();
    Fluttertoast.showToast(msg: "Exercise deleted", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }
}
