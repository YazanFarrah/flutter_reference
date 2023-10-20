import 'package:flutter/material.dart';
import 'package:flutter_reference/provider/user_places.dart';
import 'package:flutter_reference/screens/add_place.dart';
import 'package:flutter_reference/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<PlacesListScreen> createState() {
    return _PlacesListScreen();
  }
}

class _PlacesListScreen extends ConsumerState<PlacesListScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const AddPlaceScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return PlacesList(places: userPlaces);
            }),
      ),
    );
  }
}
