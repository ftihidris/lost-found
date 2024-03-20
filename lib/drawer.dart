import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showLogoutConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout Confirmation'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login'); // Navigate to the login page and replace the current route
                },
                child: const Text('Logout'),
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFF914D),
            ),
            accountName: Text('Imran'),
            accountEmail: Text('kita@gmail.com.com'),
            currentAccountPicture: CircleAvatar(
              radius: 60,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: Icon(
                Icons.person,
                size: 50,
                color: Color(0xFFFF914D),
              ),
            ),
          ),
          ListTile(
            title: const Text('Favorites'),
            textColor: const Color.fromARGB(193, 208, 96, 27),
            onTap: () {
              // Handle item 1 press
            },
          ),
          ListTile(
            title: const Text('Messages'),
            textColor: const Color.fromARGB(193, 208, 96, 27),
            onTap: () {
              // Handle item 2 press
            },
          ),
          ListTile(
            title: const Text('Privacy'),
            textColor: const Color.fromARGB(193, 208, 96, 27),
            onTap: () {
              // Handle item 3 press
            },
          ),
          ListTile(
            title: const Text('About Us'),
            textColor: const Color.fromARGB(193, 208, 96, 27),
            onTap: () {
              // Handle item 4 press
            },
          ),
          ListTile(
            title: const Text('Settings'),
            textColor: const Color.fromARGB(193, 208, 96, 27),
            onTap: () {
              Navigator.pushNamed(context, '/settings'); // Navigate to the Settings page
              // Handle item 5 press
            },
          ),
          const Spacer(), // Added Spacer widget
          GestureDetector(
            onTap: () {
              showLogoutConfirmationDialog(); // Show logout confirmation dialog
            },
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Color(0xFFFF914D),
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFFFF914D),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
