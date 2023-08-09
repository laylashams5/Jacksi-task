class Product {
  final String name;
  final String store;
  final double price;
  final String category;
  final List<String> imagePaths;
  Product({
    required this.name,
    required this.store,
    required this.price,
    required this.category,
    required this.imagePaths,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'store': store,
      'price': price,
      'category': category,
      'imagePaths': imagePaths,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      store: json['store'],
      price: json['price'],
      category: json['category'],
      imagePaths: List<String>.from(json['imagePaths']),
    );
  }
}
