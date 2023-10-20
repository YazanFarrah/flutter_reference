import 'package:flutter_reference/models/category.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class GroceryItem {
  final String? id;
  final String name;
  final int quantity;
  final Category category;
  final DateTime date;

  const GroceryItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.date,
  });

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category.title,
      'date': formattedDate,
    };
  }
}
