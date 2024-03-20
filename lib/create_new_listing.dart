import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'map_page.dart';
//import 'homepage.dart';
import 'newlisting.dart';

class Createad extends StatefulWidget {
  const Createad({Key? key}) : super(key: key);

  @override
  _CreateadState createState() => _CreateadState();
}

class _CreateadState extends State<Createad> {
  late String? _selectedCategory;
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _lastLocationController;
  String? _displayedLocation;
  bool _isLost = true;
  LatLng? _selectedLocation;
  final List<String> _imageUrls = [];

  final List<String> _categories = [
    'Select category',
    'Electronic',
    'Hardware',
    'Document',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0];
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _lastLocationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _lastLocationController.dispose();
    super.dispose();
  }

  void _navigateToMapPage() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapPage(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _displayedLocation =
            'Selected Location: ${selectedLocation.latitude}, ${selectedLocation.longitude}';
        _selectedLocation = selectedLocation;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageUrls.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF914D),
        elevation: 0,
        title: const Text(
          'Create Listing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Type:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(193, 208, 96, 27),
                ),
              ),
Align(
  alignment: Alignment.centerLeft,
  child: Row(
    children: [
      ElevatedButton(
        onPressed: () {
          setState(() {
            _isLost = true;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: _isLost ? Colors.white : Colors.black, backgroundColor: _isLost ? const Color.fromARGB(193, 208, 96, 27) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: const Text('Lost', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      const SizedBox(width: 16),
      ElevatedButton(
        onPressed: () {
          setState(() {
            _isLost = false;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: !_isLost ? Colors.white : Colors.black, backgroundColor: !_isLost ? const Color.fromARGB(193, 208, 96, 27) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: const Text('Found', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ],
  ),
),
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      margin: const EdgeInsets.only(top: 20,), // Add margin here
      child: const Text(
        'Select item category:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(193, 208, 96, 27),
        ),
      ),
    ),
    const SizedBox(height: 4),
    DropdownButton<String>(
      value: _selectedCategory,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      items: _categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
              const SizedBox(height: 20),
              const Text(
                'Item Information:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(193, 208, 96, 27),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastLocationController,
                decoration: const InputDecoration(
                  hintText: 'Last Location',
                  labelText: 'Last Location (e.g 7E Kuala Ibai)',
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Contact Information:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(193, 208, 96, 27),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Phone',
                  labelText: 'Phone',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToMapPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pin_drop_outlined, color: Color.fromARGB(193, 208, 96, 27)),
                    SizedBox(width: 8),
                    Text(
                      'Select Location',
                      style: TextStyle(color: Color.fromARGB(193, 208, 96, 27)),
                    ),
                  ],
                ),
              ),
              if (_displayedLocation != null)
                Text(
                  _displayedLocation!,
                  style: const TextStyle(fontSize: 15),
                ),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_outlined, color: Color.fromARGB(193, 208, 96, 27)),
                    SizedBox(width: 8),
                    Text(
                      'Add Image',
                      style: TextStyle(color: Color.fromARGB(193, 208, 96, 27)),
                    ),
                  ],
                ),
              ),
              if (_imageUrls.isNotEmpty)
                GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  itemCount: _imageUrls.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _imageUrls.length) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.file(File(_imageUrls[index]), fit: BoxFit.cover),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Image.file(File(_imageUrls[index])),
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _imageUrls.removeAt(index);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.2),
                                radius: 10,
                                child: const Icon(
                                  Icons.close,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewListingPage(
                          isLost: _isLost,
                          category: _selectedCategory!,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          location: _selectedLocation!,
                          imageUrls: _imageUrls,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF914D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Submit Ad', style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
            ]
        ),
      ),
      )
    );
  }
}
