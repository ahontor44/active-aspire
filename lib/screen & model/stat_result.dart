import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FitnessStatsResultsScreen extends StatelessWidget {
  final String name;
  final String gender;
  final double weight;
  final double height;
  final int age;
  final String bloodType;

  const FitnessStatsResultsScreen({
    super.key,
    required this.name,
    required this.gender,
    required this.weight,
    required this.height,
    required this.age,
    required this.bloodType,
  });

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  double calculateBMR() {
    if (gender == 'Male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
  }

  double calculateBodyFat(double bmi) {
    if (gender == 'Male') {
      return (1.20 * bmi) + (0.23 * age) - 16.2;
    } else {
      return (1.20 * bmi) + (0.23 * age) - 5.4;
    }
  }

  double calculateLeanBodyMass(double bmi, double bodyFat) {
    return weight * (100 - bodyFat) / 100;
  }

  double calculateIdealWeight() {
    return 22.5 * ((height / 100) * (height / 100));
  }

  double calculateHealthyWeight() {
    return calculateIdealWeight();
  }

  double calculateCaloriesBurned() {
    return 500; // Example: calories burned in an hour of exercise
  }

  double calculateOneRepMax() {
    return weight * (1 + (10 / 30)); // Example: Epley formula
  }

  @override
  Widget build(BuildContext context) {
    // Input validation
    if (weight <= 0 || height <= 0 || age <= 0) {
      Fluttertoast.showToast(msg: 'Invalid input values', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Please provide valid input values.'),
        ),
      );
    }
    if (weight > 300 || height > 250 || age > 120) {
      Fluttertoast.showToast(msg: 'Unrealistic input values', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Please provide realistic input values.'),
        ),
      );
    }

    double bmi = calculateBMI();
    double bmr = calculateBMR();
    double bodyFat = calculateBodyFat(bmi);
    double leanBodyMass = calculateLeanBodyMass(bmi, bodyFat);
    double idealWeight = calculateIdealWeight();
    double healthyWeight = calculateHealthyWeight();
    double caloriesBurned = calculateCaloriesBurned();
    double oneRepMax = calculateOneRepMax();

    List<Map<String, dynamic>> stats = [
      {"title": 'BMI', "value": bmi.toStringAsFixed(2), "icon": Icons.perm_data_setting_outlined},
      {"title": 'BMR', "value": '${bmr.toStringAsFixed(2)} kcal/day', "icon": Icons.scale},
      {"title": 'Body Fat', "value": '${bodyFat.toStringAsFixed(2)}%', "icon": Icons.man},
      {"title": 'Ideal Weight', "value": '${idealWeight.toStringAsFixed(2)} kg', "icon": Icons.scale_rounded},
      {"title": 'Lean Body Mass', "value": '${leanBodyMass.toStringAsFixed(2)} kg', "icon": Icons.leaderboard_sharp},
      {"title": 'Healthy Weight', "value": '${healthyWeight.toStringAsFixed(2)} kg', "icon": Icons.hail},
      {"title": 'Calories Burned', "value": '${caloriesBurned.toStringAsFixed(2)} kcal', "icon": Icons.no_food_sharp},
      {"title": 'One Rep Max', "value": '${oneRepMax.toStringAsFixed(2)} kg', "icon": Icons.sick_sharp},
      {"title": 'Blood Type', "value": bloodType, "icon": Icons.bloodtype},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$name\'s Fitness Results'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(stats[index]["icon"], size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  stats[index]["title"]!,
                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  stats[index]["value"]!,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
