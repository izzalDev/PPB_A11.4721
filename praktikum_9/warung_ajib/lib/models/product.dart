class Product {
  final int id;
  final String name;
  final String description;
  final int price; // Menggunakan int untuk price
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  // Factory method untuk membuat instance dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'], // Tidak perlu konversi
      image: json['image'],
    );
  }

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price, // Tetap int
      'image': image,
    };
  }
}
