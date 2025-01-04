import 'package:batflask/screens/batsmanScreen.dart';
import 'package:batflask/screens/bowlerScreen.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BatsmanScreen(),
    const bolwerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BatFlask"),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_cricket),
            label: 'Batsman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_handball_sharp),
            label: 'Bowler',
          ),
        ],
      ),
    );
  }
}
