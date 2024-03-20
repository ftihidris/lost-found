import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({super.key, 
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0xFFFF914D),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Listings',
          backgroundColor: Color(0xFFFF914D),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
          backgroundColor: Color(0xFFFF914D),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Messages',
          backgroundColor: Color(0xFFFF914D),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFFFFDE59),
      onTap: onItemTapped,
    );
  }
}
