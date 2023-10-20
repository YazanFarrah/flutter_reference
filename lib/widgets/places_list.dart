import 'package:flutter/material.dart';
import 'package:flutter_reference/models/place.dart';
import 'package:flutter_reference/screens/places_detail.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;
  const PlacesList({
    super.key,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return PlaceDetailsScreen(
                    place: places[index],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
