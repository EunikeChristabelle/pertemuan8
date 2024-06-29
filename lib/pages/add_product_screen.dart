import 'package:flutter/material.dart';
import 'package:pertemuan8/pages/firebase_service.dart';
import 'package:pertemuan8/pages/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = CloudFirestoreService();

  String _name = '';
  String _description = '';
  int _price = 0;
  String _category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => _name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (Rupiah)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product price';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => _category = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var newProduct = Product(
                      id: '',
                      name: _name,
                      description: _description,
                      price: _price,
                      category: _category,
                    );
                    _firestoreService.addProduct(newProduct);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
