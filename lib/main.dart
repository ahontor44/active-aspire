import 'package:active_aspire/screen/home_screen.dart';
import 'package:active_aspire/screen/home_screen_model.dart';
import 'package:active_aspire/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/settings_screen.dart';
import 'screen/add_workout_screen.dart';
import 'screen/workout_detail_screen.dart';
import 'screen/stat_result.dart';
void main() {
  runApp(MyFitnessApp());
}

class MyFitnessApp extends StatefulWidget {
  const MyFitnessApp({super.key});

  @override
  State<MyFitnessApp> createState() => _MyFitnessAppState();
}

class _MyFitnessAppState extends State<MyFitnessApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue, ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        themeMode: ThemeMode.system,
        title: 'Fitness App',
        home: HomeScreen(),
        routes: {
          '/settings': (context) => const SettingsScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/workout_detail': (context) => const WorkoutDetailScreen(workout: ''),
        },
      ),
    );
  }
}
