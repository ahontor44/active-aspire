import 'about_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
import 'workout_detail_screen.dart';
import 'add_workout_screen.dart';
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
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              enabled: true,
              iconColor: Colors.green,
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              enabled: true,
              iconColor: Colors.green,
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
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
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FitnessStatsScreen()),
          );
        },
        child: Icon(Icons.calculate),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenModel>(
      builder: (context, model, child) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: model.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showWorkoutOptions(context, model, index);
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workout: model.items[index]["title"],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(model.items[index]["icon"], size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            model.items[index]["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  showAddWorkoutDialog(context, model);
                },
                child: Text('Add New Workout'),
              ),
            ),
          ],
        );
      },
    );
  }

  void showWorkoutOptions(BuildContext context, HomeScreenModel model, int index) {
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
                    onAddWorkout: (newTitle, exercises) => model.updateWorkout(index, newTitle, exercises),
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
