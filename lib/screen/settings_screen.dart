import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  final String _selectedLanguage = 'English';
  final bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              title: Text('dark_mode'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
            ListTile(
              title: Text('language'),
              subtitle: Text(_selectedLanguage),
              onTap: () {
                _showLanguageDialog();
              },
            ),
            SwitchListTile(
              title: Text('notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {

                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog() {


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('select_language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile( title: Text('bengali'),
                value: 'Bengali',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                setState(() {

                }
                );
                },
              ),
              RadioListTile(
                title: Text('english'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {

                  });

                },
              ),
              RadioListTile(
                title: Text('spanish'),
                value: 'Spanish',
                groupValue: _selectedLanguage,
                onChanged: (String? value) {
                  setState(() {

                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
