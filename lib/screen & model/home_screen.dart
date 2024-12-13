// ignore_for_file: library_private_types_in_public_api

import 'package:active_aspire/screen%20&%20model/add_workout_screen.dart';
import 'about_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
import 'workout_detail_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'fitness_stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ProfileScreen(),
    FitnessStatsScreen(),
    SettingsScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: SizedBox(
                child: Image.asset(
                  'assets/active_aspire_logo.png',
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(
              child: SizedBox(
                height: 50,
                width: 100,
                child: ListTile(
                  dense: true,
                  leading: Icon(Icons.home_filled),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.settings),
                enabled: true,
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.info),
                enabled: true,
                title: Text('About Us', textAlign: TextAlign.start),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Fitness Stats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blueAccent,
          ),
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FitnessStatsScreen()),
                );
              },
              child: Icon(Icons.calculate),
            )
          : null,
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenModel>(
      builder: (context, model, child) {
        var defaultWorkouts =
            model.itemsWithIcons.where((item) => !item["isCustom"]).toList();
        var customWorkouts =
            model.itemsWithIcons.where((item) => item["isCustom"]).toList();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Default Workouts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: defaultWorkouts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = defaultWorkouts[index];
                  return GestureDetector(
                    onLongPress: () {
                      showWorkoutOptions(context, model, index,
                          isCustom: false);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workout: item["title"],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(item["icon"], size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            item["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Custom Workouts Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Workouts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showAddWorkoutDialog(context, model);
                        },
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.add, color: Colors.blueAccent)),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: customWorkouts.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = customWorkouts[index];
                  return GestureDetector(
                    onLongPress: () {
                      showWorkoutOptions(context, model, index, isCustom: true);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workout: item["title"],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(item["icon"], size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            item["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showWorkoutOptions(
      BuildContext context, HomeScreenModel model, int index,
      {required bool isCustom}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select an action"),
        content: Text("Do you want to edit or delete this workout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddWorkoutDialog(
                    onAddWorkout: (newTitle, exercises) => model.updateWorkout(
                        index, newTitle, exercises,
                        isCustom: isCustom),
                    existingWorkout: model.items[index]["title"],
                    existingExercises: model.items[index]["exercises"],
                  ),
                ),
              );
            },
            child: Text("Edit"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              model.deleteWorkout(index);
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  void showAddWorkoutDialog(BuildContext context, HomeScreenModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return AddWorkoutDialog(
          onAddWorkout: (workoutName, exercises) {
            model.addNewWorkout(workoutName, exercises);
          },
        );
      },
    );
  }
}
