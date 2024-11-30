class Product {
  int? _id;
  String name;
  int price;
  String description;
  String image;

  Product({
    int? id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  }) : _id = id;

  int? get id => _id;

  set id(int? id) {
    if (_id == null) {
      _id = id;
    } else {
      throw Exception('ID sudah diatur dan tidak bisa dirubah lagi');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      description: map['description'],
      image: map['image'],
      id: map['id'],
    );
  }
}
