
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFCF9F9E8),
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Image.asset(
                'assets/logo.png',
                height: 70,
                width: 70,
              ),
            ),
            const Text(
              'ParkBuddy',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.green[900],
        foregroundColor: Colors.white,
        toolbarHeight: 110,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: -5,
                  blurRadius: 10,
                  offset: Offset(0,-10))
            ]
        ),
        child: BottomNavigationBar(
          items:  const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/home.png')),
              activeIcon: ImageIcon(AssetImage('assets/home_click.png')),
              label: 'Home',
              backgroundColor: Color(0xFCF9F9E8),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/booking.png')),
              activeIcon: ImageIcon(AssetImage('assets/book_click.png')),
              label: 'Bookings',
              backgroundColor: Color(0xFCF9F9E8),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/bbq.png')),
              activeIcon: ImageIcon(AssetImage('assets/bbq_click.png')),
              label: 'Facilities',
              backgroundColor: Color(0xFCF9F9E8),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/profile.png')),
              activeIcon: ImageIcon(AssetImage('assets/profile_click.png')),
              label: 'Profile',
              backgroundColor: Color(0xFCF9F9E8),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedIconTheme: IconThemeData(
              color: Colors.green[900],
            // shadows: <Shadow>[Shadow(color: Colors.black45, blurRadius: 20.0, offset: Offset(0, 10))]
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}




