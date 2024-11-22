import 'package:inventory_app/services/services.dart';
import 'package:inventory_app/models/models.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final tableName = 'products';

  Future<void> addProduct(Product newProduct) async {
    final db = await DBService.getDatabase();
    final id = await db.insert(
      tableName,
      newProduct.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
    newProduct.id = id;
  }

  Future<List<Product>?> getAllProduct() async {
    final db = await DBService.getDatabase();
    final result = await db.query(tableName, columns: [
      'id',
      'name',
      'purchase_price',
      'selling_price',
      'stock',
    ]);
    db.close();

    if (result.isNotEmpty) {
      return result.map((productMap) => Product.fromMap(productMap)).toList();
    } else {
      return null;
    }
  }

  Future<int?> updateProduct(Product product) async {
    final db = await DBService.getDatabase();
    final result = await db.update(
      tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id.toString()],
    );
    db.close();

    return result;
  }

  Future<int?> deleteProduct(Product product) async {
    final db = await DBService.getDatabase();
    final result = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [product.id.toString()],
    );
    db.close();
    
    return result;
  }
}
