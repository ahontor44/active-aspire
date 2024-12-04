import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreenModel extends ChangeNotifier {
  static const Map<String, IconData> iconMap = {
    "directions_run": Icons.directions_run,
    "directions_bike": Icons.directions_bike,
    "pool": Icons.pool,
    "self_improvement": Icons.self_improvement,
    "fitness_center": Icons.fitness_center,
    "custom_workout": Icons.settings_suggest,
  };

  List<Map<String, dynamic>> items = [
    {"title": "Running", "icon": "directions_run", "exercises": <Map<String, dynamic>>[], "isCustom": false},
    {"title": "Cycling", "icon": "directions_bike", "exercises": <Map<String, dynamic>>[], "isCustom": false},
    {"title": "Swimming", "icon": "pool", "exercises": <Map<String, dynamic>>[], "isCustom": false},
    {"title": "Yoga", "icon": "self_improvement", "exercises": <Map<String, dynamic>>[], "isCustom": false},
    {"title": "Weight Training", "icon": "fitness_center", "exercises": <Map<String, dynamic>>[], "isCustom": false},
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
      List<Map<String, dynamic>> loadedItems = List<Map<String, dynamic>>.from(jsonDecode(data));
      // Ensure each item has the isCustom field
      items = loadedItems.map((item) {
        return {
          ...item,
          "isCustom": item["isCustom"] ?? false,
        };
      }).toList();
    }
    notifyListeners();
  }

  void addNewWorkout(String workoutName, List<Map<String, dynamic>> exercises) {
    items.add({
      "title": workoutName,
      "icon": "custom_workout",
      "exercises": exercises,
      "isCustom": true,
    });
    _saveData();
    notifyListeners();
  }

  void updateWorkout(int index, String newTitle, List<Map<String, dynamic>> exercises, {required bool isCustom}) {
    items[index] = {
      "title": newTitle,
      "icon": items[index]["icon"],
      "exercises": exercises,
      "isCustom": isCustom,
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

  List<Map<String, dynamic>> get itemsWithIcons {
    return items.map((item) {
      return {
        ...item,
        "icon": iconMap[item["icon"]],
      };
    }).toList();
  }
}
