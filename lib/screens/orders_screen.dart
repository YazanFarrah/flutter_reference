import 'package:flutter/material.dart';
import 'package:flutter_reference/widgets/app_drawer.dart';
import 'package:flutter_reference/widgets/order_item.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) {
          return OrderItem(
            order: ordersData.orders[index],
          );
        },
      ),
    );
  }
}
