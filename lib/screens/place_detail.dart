import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen(
      {super.key,
      required this.place,
      required this.image,
      required this.places});

  final String place;
  final PlaceLocation places;
  final File image;

  String get locationImage {
    final longi = places.longitude;
    final lati = places.latitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lati,$longi zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lati,$longi &key=AIzaSyCGwH3revkTLWyi9r0PEZKs7-Bilo9Tkng';
  }

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
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: Image.network(locationImage).image,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Text(
                      textAlign: TextAlign.center,
                      places.address,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
