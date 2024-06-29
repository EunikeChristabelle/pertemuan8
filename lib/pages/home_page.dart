import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pertemuan8/pages/login_page.dart';
import 'package:pertemuan8/pages/add_product_screen.dart';
import 'package:pertemuan8/pages/product_detail_screen.dart';
import 'package:pertemuan8/pages/firebase_service.dart';
import 'package:pertemuan8/pages/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudFirestoreService _firestoreService = CloudFirestoreService();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          StreamBuilder<List<Product>>(
            stream: _firestoreService.getProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var products = snapshot.data!;
              var categories = products
                  .map((product) => product.category)
                  .toSet()
                  .toList();
              categories.insert(0, 'All');

              return DropdownButton<String>(
                value: _selectedCategory,
                items: categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              );
            },
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: _firestoreService.getProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var products = snapshot.data!
                    .where((product) =>
                        (product.name.toLowerCase().contains(_searchQuery) ||
                            product.description.toLowerCase().contains(_searchQuery)) &&
                        (_selectedCategory == 'All' ||
                            product.category == _selectedCategory))
                    .toList();

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Rp ${product.price}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
