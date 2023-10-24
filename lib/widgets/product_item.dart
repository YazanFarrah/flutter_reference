import 'package:flutter/material.dart';
import 'package:flutter_reference/providers/cart_provider.dart';
import 'package:flutter_reference/providers/product.dart';
import 'package:flutter_reference/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  const ProductItem({
    super.key,
    // required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    // final cart = Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, value, _) {
              return IconButton(
                color: Theme.of(context).colorScheme.primary,
                splashRadius: 1.0,
                onPressed: () {
                  value.toggleFavoriteStatus();
                },
                icon: Icon(
                  value.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              );
            },
          ),
          trailing: Consumer<CartProvider>(
            builder: (context, value, child) => IconButton(
              onPressed: () {
                value.addItem(
                  productId: product.id,
                  price: product.price,
                  title: product.title,
                );
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product,
            );
          },
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
