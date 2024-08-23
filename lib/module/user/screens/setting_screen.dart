import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: const Color.fromARGB(255, 122, 121, 120)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: Switch(
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 163, 163, 161),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: const Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: Switch(
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 163, 163, 161),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: const Text(
                  'Language',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: DropdownButton(
                  value: 'English',
                  onChanged: (value) {},
                  items: [
                    'English',
                    'Spanish',
                    'French',
                    'Arabic',
                  ].map((language) {
                    return DropdownMenuItem(
                      value: language,
                      child: Text(language),
                    );
                  }).toList(),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 163, 163, 161),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Ecommerce App',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'Copyright 2023 Ecommerce App',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
