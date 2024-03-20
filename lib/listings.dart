import 'package:flutter/material.dart';
import 'homepage.dart';
import 'BottomNavBar.dart';
import 'map_page.dart';
import 'lnf_item.dart';
import 'drawer.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Listings(),
    );
  }
}

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Listings',
      style: optionStyle,
    ),
    Text(
      'Map',
      style: optionStyle,
    ),
    Text(
      'Messages',
      style: optionStyle,
    ),
  ]; // Set 1 to make "Listings" button active

  void handleMenuButtonPress() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void navigateToHomePage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void navigateToMap() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MapPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void navigateToMessages() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LnFItem(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      navigateToHomePage();
    } else if (index == 1) {
      // Do nothing, as we are already on the Listings page
    } else if (index == 2) {
      navigateToMap();
    } else if (index == 3) {
      navigateToMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _widgetOptions[_selectedIndex],
        backgroundColor: const Color(0xFFFF914D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: handleMenuButtonPress,
        ),
      ),
      drawer: const AppDrawer(), // Use your custom Drawer widget from drawer.dart
      body: const Center(
        child: Text(
          'add listings',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String name;
  final String lastLocation;
  final String category;

  const ListingCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.name,
    required this.lastLocation,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('By: $name'),
                Text('Last Location: $lastLocation'),
                Text('Category: $category'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
