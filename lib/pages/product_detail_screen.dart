import 'package:flutter/material.dart';
import 'package:pertemuan8/pages/product.dart';
import 'package:pertemuan8/pages/firebase_service.dart';
import 'package:pertemuan8/pages/edit_product_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final _firestoreService = CloudFirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductScreen(product: product),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _firestoreService.deleteProduct(product.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Rp ${product.price}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Text(
              'Category: ${product.category}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
