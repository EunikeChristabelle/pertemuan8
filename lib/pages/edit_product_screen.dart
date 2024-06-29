import 'package:flutter/material.dart';
import 'package:pertemuan8/pages/firebase_service.dart';
import 'package:pertemuan8/pages/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({required this.product, super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = CloudFirestoreService();

  late String _name;
  late String _description;
  late int _price;
  late String _category;

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _description = widget.product.description;
    _price = widget.product.price;
    _category = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
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
                initialValue: _description,
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
                initialValue: _price.toString(),
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
                initialValue: _category,
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
                    var updatedProduct = Product(
                      id: widget.product.id,
                      name: _name,
                      description: _description,
                      price: _price,
                      category: _category,
                    );
                    _firestoreService.updateProduct(updatedProduct);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
