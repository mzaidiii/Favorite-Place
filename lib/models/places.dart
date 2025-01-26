import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Places {
  Places({required this.Name, required this.image}) : id = uuid.v4();
  final String id;
  final String Name;
  final File image;
}
