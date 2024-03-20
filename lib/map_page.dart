import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';
import 'BottomNavBar.dart';
import 'drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart'; // Import the geolocator package
import 'listings.dart'; // Import the file where the BottomNavBar widget is defined

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({Key? key}) : super(key: key);
 
 @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapPage(),
    );
  }
}
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng? _selectedLocation;
  LatLng? _currentLocation; // Variable to store the current user's location
  // Variable to store the selected location
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;
  static const TextStyle optionStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
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
  ];// Set the initial index for the bottom navigation bar
  
  void navigateToListings() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Listings(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    ).then((value) {
      // Update the selected index when returning from Listings page
      setState(() {
        _selectedIndex = 1;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the current user's location when the page is initialized
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _selectLocation(LatLng latLng) async {
    final placeName = await _getPlaceNameFromCoordinates(latLng);
    final snackBar = SnackBar(content: Text(placeName));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      _selectedLocation = latLng;
    });
  }

  void handleMenuButtonPress() {
    _scaffoldKey.currentState?.openDrawer();
  }

   void navigateToHomePage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
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
      navigateToListings();
  }
  }
  void _deleteSelectedLocation() {
    setState(() {
      _selectedLocation = null;
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
      ),
      drawer: const AppDrawer(),
      body: _currentLocation != null // Check if current location is available
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!, // Use the current user's location as the initial camera position
                zoom: 11.0,
              ),
              onTap: _selectLocation,
              markers: 
                   {
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: _currentLocation!,
                        infoWindow: const InfoWindow(title: 'Current Location'),
                      ),
                      if (_selectedLocation != null)
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: _selectedLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    infoWindow: const InfoWindow(title: 'Selected Location'),
                  ),
                    },
                    myLocationEnabled: true,
            )
          : const Center(
              child: CircularProgressIndicator(), // Show a loading indicator while getting the current location
            ),
      floatingActionButton: _selectedLocation != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, _selectedLocation);
              },
              child: const Icon(Icons.check),
            )
            
          : null,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}