import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
  final double latitude;
  final double longitude;
  final String address;
}

class Places {
  Places(
      {required this.Name,
      required this.image,
      required this.location,
      String? id})
      : id = uuid.v4();
  final String id;
  final String Name;
  final File image;
  final PlaceLocation location;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': Name,
      'address': location.address,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'imagePath': image.path,
    };
  }
}
