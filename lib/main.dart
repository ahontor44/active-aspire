import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen & model/theme_provider.dart';
import 'screen & model/home_screen.dart';
import 'screen & model/home_screen_model.dart';
import 'screen & model/profile_screen.dart';
import 'screen & model/settings_screen.dart';
import 'screen & model/workout_detail_screen.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
    child: MyFitnessApp(),
    ),
  );
}
class MyFitnessApp extends StatefulWidget {
  const MyFitnessApp({super.key});
  @override
  State<MyFitnessApp> createState() => _MyFitnessAppState();
}
class _MyFitnessAppState extends State<MyFitnessApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
            ),
            themeMode: themeProvider.themeMode,
            title: 'Fitness App',
            home: HomeScreen(),
            routes: {
              '/settings': (context) => const SettingsScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/workout_detail': (context) => const WorkoutDetailScreen(workout: ''),
            },
          );
        },
      ),
    );
  }
}
