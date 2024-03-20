import 'dart:io';
import 'package:lostnfound/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewListingPage extends StatelessWidget {

  
  final bool isLost; 
  final String category;
  final String title;
  final String description;
  final LatLng location;
  final List<String> imageUrls;

  const NewListingPage({super.key, 
    required this.isLost,
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Listing'),
        backgroundColor: const Color(0xFFFF914D),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigate back to the homepage (Createad widget) and remove NewListingPage from the navigation stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false, // Remove all other routes from the stack
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
      'Type: ${isLost ? 'Lost' : 'Found'}', // Show "Lost" if isLost is true, otherwise show "Found"
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
            const SizedBox(height: 10),
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Title: $title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: ${location.latitude}, ${location.longitude}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Images:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.file(File(imageUrls[index]));
              },
            ),
          ],
        ),
      ),
    );
  }
}
