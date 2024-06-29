import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/product.dart';

class CloudFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new product
  Future<void> addProduct(Product product) async {
    await _firestore.collection('products').add(product.toMap());
  }

  // Read a stream of products
  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Update an existing product
  Future<void> updateProduct(Product product) async {
    await _firestore.collection('products').doc(product.id).update(product.toMap());
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
