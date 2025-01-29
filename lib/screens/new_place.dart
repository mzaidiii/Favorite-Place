import 'dart:io';

import 'package:favorite_places/Widget/location_input.dart';
import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places/Widget/Image_input.dart';

class NewPlace extends StatefulWidget {
  @override
  State<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final TextEditingController _placeController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? selLocation;

  void saveBack() {
    final placeName = _placeController.text;

    if (placeName.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide both a name and an image!')),
      );
      return;
    }

    Navigator.of(context).pop({
      'name': placeName,
      'image': _selectedImage,
      'location': selLocation,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _placeController,
              decoration: InputDecoration(label: Text('Name')),
              maxLength: 100,
            ),
            const SizedBox(height: 16),
            ImageInput(
              onPickedimage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 16),
            LocationInput(
              onselectedLocation: (loc) {
                print(
                    'Location received: ${loc.address}, ${loc.latitude}, ${loc.longitude}');
                selLocation = loc;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveBack,
              child: Text(
                'Save Place',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
