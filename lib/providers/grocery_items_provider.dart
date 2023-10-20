import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_reference/data/categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_reference/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryItemsNotifier() : super([]);
  final url = Uri.https(
    'flutter-shopping-app-34b11-default-rtdb.firebaseio.com',
    'shopping-list.json',
  );

  Future<void> addItem(GroceryItem item, BuildContext context) async {
    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(item.toMap()),
      );
      if (!context.mounted) {
        return;
      }
      final sortedItems =
          SplayTreeSet<GroceryItem>((a, b) => b.date.compareTo(a.date));
      sortedItems.addAll(state); // Copy the current items to the sorted set.
      sortedItems.add(item); // Add the new item.

      state = sortedItems.toList(); // Convert back to a list for state.
      Navigator.pop(
        context,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      print(
        e.toString(),
      );
    }
    // state = [...state, item];
    // state.sort((a, b) => b.date.compareTo(a.date));
    // Use a SplayTreeSet for initial sorting when fetching.
  }

  Future<void> getItems(BuildContext context) async {
    try {
      final response = await http.get(url);
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data == null || data.isEmpty) {
        print('db is empty');
        return;
      }
      final List<GroceryItem> items = data.entries.map((entry) {
        final id = entry.key;
        final itemData = entry.value;
        final category = categories.entries.firstWhere((categoryItem) {
          return categoryItem.value.title == itemData['category'];
        }).value;
        final date = DateTime.tryParse(itemData['date']) ?? DateTime.now();
        return GroceryItem(
            id: id,
            name: itemData['name'],
            quantity: itemData['quantity'],
            category: category,
            date: date);
      }).toList();

      // Sort the items by date in descending order (most recent first).
      items.sort((a, b) => b.date.compareTo(a.date));

      state = [...state, ...items];
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
      print(e.toString());
    }
  }

  void removeItem({
    required GroceryItem item,
    required int index,
    required BuildContext context,
  }) async {
    bool deleteItem = true;

    state.removeAt(index);

    state = [...state];

    // Show the Snackbar with an Undo option.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${item.name} was deleted",
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            deleteItem = false;
            state.insert(index, item);
            state = [...state];
          },
        ),
      ),
    );

    try {
      if (deleteItem) {
        await Future.delayed(const Duration(seconds: 3), () async {
          // Perform the HTTP delete request.
          final response = await http.delete(
            Uri.https(
              'flutter-shopping-app-34b11-default-rtdb.firebaseio.com',
              'shopping-list/${item.id}.json',
            ),
          );

          if (response.statusCode == 200) {
            // Item was successfully deleted from the server.
            final newState =
                state.where((newItem) => newItem.id != item.id).toList();
            state = newState; // Update the state with the new list.
          } else {
            // Handle the case where the server couldn't delete the item.
            if (!context.mounted) {
              return;
            }

            // Revert the UI state.
            state.insert(index, item);
            state = [...state];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Couldn't delete item: ${item.name}"),
              ),
            );
          }
        });
      }
    } catch (e) {
      if (!context.mounted) {
        return;
      }
      state.insert(index, item);

      state = [...state];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Couldn't delete item: ${item.name}",
          ),
        ),
      );
      print(
        e.toString(),
      );
    }
  }
}

final groceryItemsProvider =
    StateNotifierProvider<GroceryItemsNotifier, List<GroceryItem>>(
  (ref) {
    return GroceryItemsNotifier();
  },
);
