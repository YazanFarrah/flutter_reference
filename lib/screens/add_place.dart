import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reference/models/place.dart';
import 'package:flutter_reference/provider/user_places.dart';
import 'package:flutter_reference/widgets/image_input.dart';
import 'package:flutter_reference/widgets/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  final _formKey = GlobalKey<FormState>();
  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (_formKey.currentState!.validate() &&
        _selectedImage != null &&
        _selectedLocation != null) {
      ref.read(userPlacesProvider.notifier).addPlace(
            title: enteredTitle,
            image: _selectedImage!,
            location: _selectedLocation!,
          );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  controller: _titleController,
                ),
                const SizedBox(height: 10),
                //Image input
                ImageInput(
                  onPickImage: (image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(height: 16),
                LocationInput(
                  onSelectLocation: (location) {
                    _selectedLocation = location;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  label: const Text('Add place'),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          )),
    );
  }
}
