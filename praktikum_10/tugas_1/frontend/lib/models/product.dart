class Product {
  int? id;
  String name;
  int purchasePrice;
  int sellingPrice;
  int stock;
  DateTime? createdAt;
  DateTime? editedAt;

  Product({
    this.id,
    this.createdAt,
    this.editedAt,
    required this.name,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stock,
  });

  toMap() {}

  fromMap() {}
}
