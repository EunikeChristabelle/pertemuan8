import 'package:flutter/material.dart';
import 'package:pertemuan8/pages/firebase_service.dart';
import 'package:pertemuan8/pages/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CloudFirestoreService _firestoreService = CloudFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _firestoreService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var products = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Rp ${product.price}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(product.description),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Category: ${product.category}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditProductDialog(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _firestoreService.deleteProduct(product.id),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog() {
    String name = '';
    String description = '';
    int price = 0;
    String category = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price (Rupiah)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = int.tryParse(value) ?? 0,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => category = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var newProduct = Product(
                  id: '',
                  name: name,
                  description: description,
                  price: price,
                  category: category,
                );
                _firestoreService.addProduct(newProduct);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(Product product) {
    String name = product.name;
    String description = product.description;
    int price = product.price;
    String category = product.category;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
                controller: TextEditingController(text: product.name),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
                controller: TextEditingController(text: product.description),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price (Rupiah)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = int.tryParse(value) ?? 0,
                controller: TextEditingController(text: product.price.toString()),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => category = value,
                controller: TextEditingController(text: product.category),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var updatedProduct = Product(
                  id: product.id,
                  name: name,
                  description: description,
                  price: price,
                  category: category,
                );
                _firestoreService.updateProduct(updatedProduct);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
