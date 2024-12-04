import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenModel extends ChangeNotifier {
  List<Map<String, dynamic>> items = [
    {"title": "Running", "icon": Icons.directions_run, "exercises": <Map<String, dynamic>>[]},
    {"title": "Cycling", "icon": Icons.directions_bike, "exercises": <Map<String, dynamic>>[]},
    {"title": "Swimming", "icon": Icons.pool, "exercises": <Map<String, dynamic>>[]},
    {"title": "Yoga", "icon": Icons.self_improvement, "exercises": <Map<String, dynamic>>[]},
    {"title": "Weight Training", "icon": Icons.fitness_center, "exercises": <Map<String, dynamic>>[]},
  ];

  HomeScreenModel() {
    _loadData();
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('workoutData', jsonEncode(items));
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('workoutData');
    if (data != null) {
      items = List<Map<String, dynamic>>.from(jsonDecode(data));
      notifyListeners();
    }
  }

  void addNewWorkout(String workoutName, List<Map<String, dynamic>> exercises) {
    items.add({
      "title": workoutName,
      "icon": Icons.fitness_center,
      "exercises": exercises,
    });
    _saveData();
    notifyListeners();
  }

  void updateWorkout(int index, String newTitle, List<Map<String, dynamic>> exercises) {
    items[index] = {
      "title": newTitle,
      "icon": items[index]["icon"],
      "exercises": exercises,
    };
    _saveData();
    notifyListeners();
  }

  void deleteWorkout(int index) {
    items.removeAt(index);
    _saveData();
    notifyListeners();
  }

  void addExercise(int workoutIndex, Map<String, dynamic> exercise) {
    items[workoutIndex]["exercises"].add(exercise);
    _saveData();
    notifyListeners();
  }

  void updateExercise(int workoutIndex, int exerciseIndex, Map<String, dynamic> updatedExercise) {
    items[workoutIndex]["exercises"][exerciseIndex] = updatedExercise;
    _saveData();
    notifyListeners();
  }

  void deleteExercise(int workoutIndex, int exerciseIndex) {
    items[workoutIndex]["exercises"].removeAt(exerciseIndex);
    _saveData();
    notifyListeners();
  }
}
