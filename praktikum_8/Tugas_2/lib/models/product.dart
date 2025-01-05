class Product {
  int? _id;
  String name;
  int purchasePrice;
  int sellingPrice;
  int stock;

  Product({
    int? id,
    required this.name,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stock,
  }) : _id = id;

  // Mendapatkan ID produk
  int? get id => _id;

  // Menetapkan ID produk, hanya bisa diset sekali
  set id(int? id) {
    if (_id == null) {
      _id = id;
    } else {
      throw Exception('ID sudah diatur dan tidak bisa dirubah lagi');
    }
  }

  // Mengonversi produk ke dalam bentuk Map
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': name,
      'purchase_price': purchasePrice,
      'selling_price': sellingPrice,
      'stock': stock,
    };
  }

  // Membuat produk dari Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      purchasePrice: map['purchase_price'],
      sellingPrice: map['selling_price'],
      stock: map['stock'],
      id: map['id'],
    );
  }
}
