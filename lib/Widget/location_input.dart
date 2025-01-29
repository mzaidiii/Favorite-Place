import 'dart:convert';

import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onselectedLocation});

  final void Function(PlaceLocation loc) onselectedLocation;
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _gettingLocation = false;

  Future<void> saveLocation(double latitu, double longitu) async {
    final Url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitu,$longitu &key=AIzaSyCGwH3revkTLWyi9r0PEZKs7-Bilo9Tkng');

    final response = await http.get(Url);
    final resData = json.decode(response.body);
    final addres = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: latitu, longitude: longitu, address: addres);
      _gettingLocation = false;
    });
    widget.onselectedLocation(_pickedLocation!);
  }

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final longi = _pickedLocation!.longitude;
    final lati = _pickedLocation!.latitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lati,$longi zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lati,$longi &key=AIzaSyCGwH3revkTLWyi9r0PEZKs7-Bilo9Tkng';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _gettingLocation = true;
    });

    locationData = await location.getLocation();
    var lat = locationData.latitude;
    var lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }
    final Url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng &key=AIzaSyCGwH3revkTLWyi9r0PEZKs7-Bilo9Tkng');

    final response = await http.get(Url);
    final resData = json.decode(response.body);
    final addres = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: addres);
      _gettingLocation = false;
    });
    widget.onselectedLocation(_pickedLocation!);
  }

  void selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapPicked(),
      ),
    );

    if (pickedLocation == null) {
      return;
    }

    saveLocation(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget preViewContent = Text(
      'No Location Added yet..!',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_pickedLocation != null) {
      preViewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }
    if (_gettingLocation) {
      preViewContent = CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: preViewContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: Text('current location'),
              icon: Icon(Icons.location_on),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              label: Text('Select on map'),
              icon: Icon(Icons.map),
            ),
          ],
        )
      ],
    );
  }
}
