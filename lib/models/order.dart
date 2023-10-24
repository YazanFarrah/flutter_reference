import 'package:flutter_reference/models/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}
