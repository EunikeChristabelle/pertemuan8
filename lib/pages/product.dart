class Product {
  String id;
  String name;
  String description;
  int price; // Dalam Rupiah
  String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      category: data['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
    };
  }
}
