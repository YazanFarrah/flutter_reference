import 'package:flutter/material.dart';
import 'package:flutter_reference/models/cart.dart';
import 'package:flutter_reference/models/order.dart';
import 'package:uuid/uuid.dart';

class OrdersProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder({
    required List<CartItems> cartProducts,
    required double total,
  }) {
    const Uuid uuid = Uuid();
    //0 to insert at the beggining of the list

    _orders.insert(
      0,
      Order(
        id: uuid.v4(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
