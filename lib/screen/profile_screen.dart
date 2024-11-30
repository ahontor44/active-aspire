import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),),

      body: Padding( padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.png'), // Placeholder image
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Profile Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {
                // Navigate to edit profile screen
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Change Password'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification Settings'),
              onTap: () {
                // Navigate to notification settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Handle log out
              },
            ),
          ],
        ),
      ),
    );
  }
}
