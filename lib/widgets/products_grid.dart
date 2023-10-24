import 'package:flutter/material.dart';
import 'package:flutter_reference/providers/products.dart';
import 'package:flutter_reference/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  const ProductsGrid({
    super.key,
    required this.showFavs,
  });

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 2,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) {
        return ChangeNotifierProvider.value(
          // note: the good thing abt changeNotifier is that it cleans itself so there's no memory leak
          value: products[i],
          child: const ProductItem(
              // product: products[i],
              ),
        );
      },
    );
  }
}
