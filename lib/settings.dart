import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF914D),
        elevation: 0, // Set elevation to 0 to remove the shadow
      ),
      body: ListView(
        children: [
          buildSettingItem(
            icon: Icons.account_circle,
            title: 'Account',
            iconColor: const Color(0xFFFF914D),
          ),
          buildSettingItem(
            icon: Icons.notifications,
            title: 'Notification',
            iconColor: const Color(0xFFFF914D),
          ),
          buildSettingItem(
            icon: Icons.lock,
            title: 'Privacy & Security',
            iconColor: const Color(0xFFFF914D),
          ),
          buildSettingItem(
            icon: Icons.help,
            title: 'Help and Support',
            iconColor: const Color(0xFFFF914D),
          ),
          buildSettingItem(
            icon: Icons.info,
            title: 'About',
            iconColor: const Color(0xFFFF914D),
          ),
        ],
      ),
    );
  }

  Widget buildSettingItem({required IconData icon, required String title, required Color iconColor}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1.0)), // Add a bottom border
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        iconColor : const Color.fromARGB(193, 208, 96, 27),
        onTap: () {
          // Add functionality for when each setting is tapped.
          // For example, you can navigate to a specific settings page.
          // You can implement this based on your app's requirements.
        },
      ),
    );
  }
}
