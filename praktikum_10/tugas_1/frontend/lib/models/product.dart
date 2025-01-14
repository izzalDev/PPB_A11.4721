import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stock': stock,
      'createdAt': createdAt?.toIso8601String(),
      'editedAt': editedAt?.toIso8601String(),
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      purchasePrice: map['purchasePrice'],
      sellingPrice: map['sellingPrice'],
      stock: map['stock'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      editedAt: map['editedAt'] != null ? DateTime.parse(map['editedAt']) : null,
    );
  }
}
