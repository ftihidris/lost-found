import 'dart:convert';
import 'package:lostnfound/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'BottomNavBar.dart';
import 'create_new_listing.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'lnf_item.dart';
import 'listings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'map_page.dart';
import 'package:carousel_slider/carousel_slider.dart';


void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  get user => null;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _username = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? _currentLocation;

  int _selectedIndex = 0;
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
  ];

  void handleMenuButtonPress() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void navigateToCreateAd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Createad()),
    );
  }

  void navigateToLnFItem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LnFItem()),
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

  void navigateToListings() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Listings(),
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

  void _onItemTapped(int index) {
    if (index == 0) {
      // If already on Home page, do nothing
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      navigateToListings();
    } else if (index == 2) {
      navigateToMap();
    }
  }

  @override
 void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchUserData();
  }

  void _fetchUserData() {
    FirebaseAuthService().getUsername(widget.user?.uid ?? '').then((username) {
      setState(() {
        _username = username;
        print("_username: $_username");
      });
    }).catchError((error) {
      print("Error fetching user data: $error");
    });
}
  
 void _getCurrentLocation() async {
  // Check if location permission is granted
  if (await Permission.location.isGranted) {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  } else {
    // If location permission is not granted, request the permission
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      // If the user grants the permission, get the current location
      _getCurrentLocation();
    } else {
      // If the user denies the permission, handle it (e.g., show a message or disable location-related features)
      print("Location permission denied.");
    }
  }
}

void main() {
  runApp(const BottomNavigationBarExampleApp());
  _requestLocationPermission(); // Request location permission when the app starts
}

void _requestLocationPermission() async {
  PermissionStatus permissionStatus = await Permission.location.request();
  if (permissionStatus.isGranted) {
    print("Location permission granted.");
  } else {
    print("Location permission denied.");
  }
}

  Future<String> _getPlaceNameFromCoordinates(LatLng coordinates) async {
    const apiKey = 'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with your Google Maps API Key
    final endpoint =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];

      if (results != null && results.isNotEmpty) {
        return results[0]['formatted_address'];
      }
    }

    return 'Unknown Place';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // Your desired icon (e.g., add icon)
            onPressed: () {
              // Add your action here when the icon is pressed
              navigateToCreateAd(); // Example: navigate to the create ad screen
            },
          ),
        ],

      ),
      drawer: const AppDrawer(), // Use the AppDrawer widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft, // Align the text to the top left
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 16, // Set the font size to 20
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(193, 208, 96, 27),
                    ),
                  ),
                  
                  Text(
                    _username.isNotEmpty ? '$_username' : 'Imran',
                    style: const TextStyle(
                      fontSize: 45, // Set the font size to 15
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF914D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFF914D),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  // Add the drop shadow
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: InkWell(
                onTap: navigateToCreateAd,
                child: const Center(
                  child: Text(
                    'Create a new listing',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two boxes per row
                mainAxisSpacing: 16, // Space between the boxes vertically
                crossAxisSpacing: 16, // Space between the boxes horizontally
                children: [
                  _buildBoxWithLabel('Your Listing', const Color.fromARGB(255, 255, 255, 255), 0), 
                  _buildBoxWithLabel('New Listing', const Color.fromARGB(255, 255, 255, 255), 1),
                  _buildBoxWithLabel('Sponsored', const Color.fromARGB(255, 255, 255, 255), 2),
                   _buildBoxWithLabel('Map', const Color.fromARGB(255, 255, 255, 255), 3),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBoxWithLabel(String label, Color boxColor, int index) {
  if (index == 0) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/IMG_5563 Large.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            bottom: 8,
            left: 10,
            child: Text(
              'Your Listings',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF914D),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (index == 1) {
    return Material(
      elevation: 5, // Add the drop shadow
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          // Add navigation or other actions for the carousel slider
        },
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
  height: 200, // Set the height of the carousel slider
  autoPlay: true,
  aspectRatio: 5 / 9 ,
  enlargeCenterPage: true,
  scrollDirection: Axis.horizontal,

              ),
              items: [
                'assets/images/IMG_4436 Large.jpeg',
                'assets/images/IMG_4435 Large.jpeg',
                'assets/images/IMG_4433 Large.jpeg',
                // Add more image paths here
              ].map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              bottom: 8,
              left: 10,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF914D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } else if (index == 3 && _currentLocation != null) {
  return Material(
    elevation: 5, // Add the drop shadow
    borderRadius: BorderRadius.circular(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10), // Apply border radius here
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation!, // Use the current location as the initial camera position
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('map_marker'),
            position: _currentLocation!,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        },
        myLocationEnabled: true,
      ),
    ),
  );
} else if (index == 2) {
  return Material(
    elevation: 5, // Add the drop shadow
    borderRadius: BorderRadius.circular(10),
    child: GestureDetector(
      onTap: () {
        // Add navigation or other actions for the "Sponsored" box
      },
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true, // Enable auto play for the slideshow
              aspectRatio: 4 / 4,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: [
              'assets/images/sponsored.jpg',
              'assets/images/sponsor2.jpeg',
              'assets/images/sponsor3.jpeg',
              // Add more image paths here
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal:0,vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 8,
            left: 10,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF914D),
              ),
            ),
          ),
        ],
      ),
    ),
  );
} else {
      return Material(
        elevation: 5, // Add the drop shadow
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            // Add navigation or other actions for other boxes
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 10,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF914D),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
