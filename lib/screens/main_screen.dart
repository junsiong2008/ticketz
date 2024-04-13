import 'package:provider/provider.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/screens/attendance_screen.dart';
import 'package:ticketz/screens/home_screen.dart';
import 'package:ticketz/screens/participant_screen.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    const HomeScreen(),
    const ParticipantScreen(),
    const AttendanceScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      Provider.of<SearchProvider>(context, listen: false).clearQuery();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Material(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 0,
                blurRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: BottomNavigationBar(
              selectedItemColor: kPrimaryColor,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.face_outlined),
                  activeIcon: Icon(Icons.face),
                  label: 'Participants',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.badge_outlined),
                  activeIcon: Icon(Icons.badge),
                  label: 'Attendance',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
