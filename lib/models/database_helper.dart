import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:favorite_places/models/places.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'places.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, address TEXT, latitude REAL, longitude REAL, imagePath TEXT)',
        );
      },
    );
  }

  Future<void> insertPlace(Places place) async {
    final db = await database;
    await db.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Places>> getPlaces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('places');

    return List.generate(maps.length, (i) {
      return Places(
        id: maps[i]['id'],
        Name: maps[i]['title'],
        image: File(maps[i]['imagePath']),
        location: PlaceLocation(
          latitude: maps[i]['latitude'],
          longitude: maps[i]['longitude'],
          address: maps[i]['address'],
        ),
      );
    });
  }
}
