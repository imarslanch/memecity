// notification_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Initialize settings with default values
  bool _messagesEnabled = true;
  bool _friendRequestsEnabled = true;
  bool _updatesEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification Settings',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Messages'),
              value: _messagesEnabled,
              onChanged: (value) {
                setState(() {
                  _messagesEnabled = value;
                });
                // Save settings here if needed
              },
            ),
            SwitchListTile(
              title: const Text('Friend Requests'),
              value: _friendRequestsEnabled,
              onChanged: (value) {
                setState(() {
                  _friendRequestsEnabled = value;
                });
                // Save settings here if needed
              },
            ),
            SwitchListTile(
              title: const Text('Updates'),
              value: _updatesEnabled,
              onChanged: (value) {
                setState(() {
                  _updatesEnabled = value;
                });
                // Save settings here if needed
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                  foregroundColor: Colors.white),
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }

  void _saveSettings() {
    // Implement your logic to save settings here
    // For example, save to shared preferences or a backend service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }
}
