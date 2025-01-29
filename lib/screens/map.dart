import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPicked extends StatefulWidget {
  const MapPicked({
    super.key,
    this.locations =
        const PlaceLocation(latitude: 37.22, longitude: -122.084, address: ''),
    this.isSelecte = true,
  });

  final PlaceLocation locations;
  final bool isSelecte;
  @override
  State<MapPicked> createState() {
    return _MapPickedState();
  }
}

class _MapPickedState extends State<MapPicked> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecte ? 'Pick Your Location ' : 'Your location'),
        actions: [
          if (widget.isSelecte)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.locations.latitude, widget.locations.longitude),
            zoom: 16),
        markers: (_pickedLocation == null && widget.isSelecte)
            ? {}
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(widget.locations.latitude,
                          widget.locations.longitude),
                ),
              },
      ),
    );
  }
}
