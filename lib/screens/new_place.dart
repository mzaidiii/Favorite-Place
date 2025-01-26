import 'dart:io';

import 'package:favorite_places/Widget/Image_input.dart';
import 'package:flutter/material.dart';

class NewPlace extends StatefulWidget {
  @override
  State<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final TextEditingController _placeController = TextEditingController();
  File? _seletctedImage;

  var placename = '';

  void saveback() {
    placename = _placeController.text;
    if (placename.isEmpty) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).pop(placename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Place'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _placeController,
            decoration: InputDecoration(label: Text('Name')),
            maxLength: 100,
            onChanged: (value) => placename = value,
          ),
          const SizedBox(
            height: 4,
          ),
          ImageInput(
            onPickedimage: (image) {
              _seletctedImage = image;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: saveback,
              child: Text(
                'Save Place',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
