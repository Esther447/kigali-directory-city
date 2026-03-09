import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool notificationsEnabled = true;

    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(title: Text('Settings'), backgroundColor: Color(0xFF111328)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Color(0xFFFFB300)),
              title: Text(auth.user?.email ?? '', style: TextStyle(color: Colors.white)),
              subtitle: Text('User Profile', style: TextStyle(color: Colors.white70)),
            ),
            Divider(color: Colors.white54),
            SwitchListTile(
              title: Text('Enable Location Notifications', style: TextStyle(color: Colors.white)),
              value: notificationsEnabled,
              onChanged: (val) {
                notificationsEnabled = val;
              },
              activeColor: Color(0xFFFFB300),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => auth.logout(),
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFB300)),
            ),
          ],
        ),
      ),
    );
  }
}