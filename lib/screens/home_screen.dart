import 'package:flutter/material.dart';
import 'directory_screen.dart';
import 'my_listings_screen.dart';
import 'map_view_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = [
    DirectoryScreen(),
    MyListingsScreen(),
    MapViewScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFFFB300),
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Directory'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Listings'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map View'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}