import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FitnessStatsModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = '';
  String gender = 'Male';
  String bloodType = 'O+';
  double weight = 0.0;
  double height = 0.0;
  int age = 0;
  double bmi = 0.0;
  double bmr = 0.0;
  double bodyFat = 0.0;
  double idealWeight = 0.0;
  double pace = 0.0;
  double leanBodyMass = 0.0;
  double healthyWeight = 0.0;
  double caloriesBurned = 0.0;
  double oneRepMax = 0.0;
  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> bloodTypeOptions = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }

  void updateBloodType(String newBloodType) {
    bloodType = newBloodType;
    notifyListeners();
  }

  void updateWeight(String value) {
    try {
      weight = double.parse(value);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please enter a valid number for weight.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void updateHeight(String value) {
    try {
      height = double.parse(value);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please enter a valid number for height.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void updateAge(String value) {
    try {
      age = int.parse(value);
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please enter a valid number for age.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void calculateStats() {
    if (weight <= 0 || height <= 0 || age <= 0) {
      Fluttertoast.showToast(
        msg: 'Please enter valid values.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    if (weight > 300 || height > 250 || age > 120) {
      Fluttertoast.showToast(
        msg: 'Please enter realistic values.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    bmi = weight / ((height / 100) * (height / 100));
    if (gender == 'Male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      bodyFat = (1.20 * bmi) + (0.23 * age) - 16.2;
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      bodyFat = (1.20 * bmi) + (0.23 * age) - 5.4;
    }
    idealWeight = 22.5 * ((height / 100) * (height / 100));
    pace = 60.0 / 10.0;
    leanBodyMass = (weight * (100 - bodyFat)) / 100;
    healthyWeight = idealWeight;
    caloriesBurned = 500;
    oneRepMax = weight * (1 + (10 / 30));
    notifyListeners();
  }
}
