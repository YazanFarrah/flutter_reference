import 'package:flutter/material.dart';
import 'package:flutter_reference/providers/product.dart';
import 'package:flutter_reference/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    //used listen false here because we only want the data "appBar title" to be fetched
    //once and this build method not to be triggered for every change happens in the provider
    final fetchedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(id: product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(fetchedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: fetchedProduct.id,
                child: Image.network(
                  fetchedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${fetchedProduct.price}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                fetchedProduct.description,
                style: Theme.of(context).textTheme.titleLarge!,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
