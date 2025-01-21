import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places {
  Places({required this.Name}) : id = uuid.v4();
  final String id;
  final String Name;
}
