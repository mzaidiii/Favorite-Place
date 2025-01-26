import 'package:favorite_places/screens/place_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/provider/place_name_provider.dart';

class FrontScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final placesNotifier = ref.watch(placesProvider.notifier);

    void newPlace() async {
      final response = await Navigator.of(context).push<Map<String, dynamic>>(
        MaterialPageRoute(builder: (ctx) => NewPlace()),
      );

      if (response != null && response.isNotEmpty) {
        placesNotifier.update((state) => [...state, response]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
          style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: newPlace, icon: Icon(Icons.add)),
        ],
      ),
      body: places.isEmpty
          ? Center(
              child: Text(
              'No places added yet.',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
          : ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: place['image'] != null
                        ? Image.file(
                            place['image'],
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                    title: Text(place['name']),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlaceDetailScreen(
                                place: place['name'],
                                image: place['image'],
                              )));
                    },
                  ),
                );
              },
            ),
    );
  }
}
