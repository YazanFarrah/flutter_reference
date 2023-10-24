import 'package:flutter/material.dart';
import 'package:flutter_reference/enums/filter_options_products_overview.dart';
import 'package:flutter_reference/providers/cart_provider.dart';
import 'package:flutter_reference/screens/cart_screen.dart';
import 'package:flutter_reference/widgets/app_drawer.dart';
import 'package:flutter_reference/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({
    super.key,
  });

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavoritesData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              if (value == FilterOptions.Favorites) {
                setState(() {
                  _showOnlyFavoritesData = true;
                });
              } else {
                setState(() {
                  _showOnlyFavoritesData = false;
                });
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: FilterOptions.Favorites, child: Text('Favorites')),
              PopupMenuItem(value: FilterOptions.All, child: Text('All')),
            ],
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
          Consumer<CartProvider>(
            //no need for the iconButton to be rebuilt so used the consumer's child
            builder: (context, value, consumerChild) => CustomBadge(
              value: value.itemCount.toString(),
              color: Colors.red,
              child: consumerChild!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(showFavs: _showOnlyFavoritesData),
    );
  }
}
