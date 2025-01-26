import 'package:flutter/material.dart';
import 'dart:io';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen(
      {super.key, required this.place, required this.image});

  final String place;
  final File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place),
      ),
      body: Stack(
        children: [
          Image.file(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
