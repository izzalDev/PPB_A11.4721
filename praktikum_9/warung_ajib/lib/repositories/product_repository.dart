import 'package:warung_ajib/models/models.dart';
import 'package:warung_ajib/services/db_service.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final tableName = 'products';

  Future<Product> addProduct(Product newProduct) async {
    final db = await DBService.getDatabase();
    final id = await db.insert(
      tableName,
      newProduct.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    newProduct.id = id;
    return newProduct;
  }

  Future<List<Product>?> getAllProduct() async {
    final db = await DBService.getDatabase();
    final result = await db.query(tableName, columns: [
      'id',
      'name',
      'description',
      'price',
      'image',
    ]);

    if (result.isNotEmpty) {
      return result.map((productMap) => Product.fromMap(productMap)).toList();
    } else {
      return null;
    }
  }

  Future<int?> updateProduct(Product product) async {
    if (product.id == null) {
      throw Exception('Product ID cannot be null');
    }

    final db = await DBService.getDatabase();
    final result = await db.update(
      tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id], // Ensure the id is not null
    );
    return result;
  }

  Future<int?> deleteProduct(Product product) async {
    final db = await DBService.getDatabase();
    final result = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [product.id],
    );
    return result;
  }
}
