import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        'name': 'Akram Hossain',
        'role': 'Flutter Dev',
        'email': 'akram241-15-750@diu.edu.bd',
        'image': 'assets/profile_picture.png', // Placeholder image
      },
      {
        'name': 'B.M Zayed',
        'role': 'Member',
        'email': 'zayed241-15-279@diu.edu.bd',
        'image': 'assets/profile_picture2.png', // Placeholder image
      },
      {
        'name': 'Md Adnan Islam',
        'role': 'Member',
        'email': 'islam241-15-471@diu.edu.bd',
        'image': 'assets/profile_picture3.png',
      },
      {
        'name': 'Mohammed Tawhidul Hoque',
        'role': 'Member',
        'email': 'tawhidul2305101307@diu.edu.bd',
        'image': 'assets/profile_picture4.png',
      },
      {
        'name': 'Md.Shahriar Hossain Nibir',
        'role': 'Member',
        'email': 'nibir2305101706@diu.edu.bd',
        'image': 'assets/profile_picture5.png',
      },
      // Add more team members here
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Team Fullstop',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(member['image']!),
                          ),
                          SizedBox(height: 20),
                          Text(
                            member['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            member['role']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchEmail(member['email']!);
                            },
                            child: Text(
                              member['email']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=App Inquiry&body=Hello,', // Add subject and body here
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      print('Could not launch $emailUri');
    }
  }
}
