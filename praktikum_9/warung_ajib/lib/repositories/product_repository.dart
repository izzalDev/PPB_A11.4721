import 'package:warung_ajib/models/models.dart';
import 'package:warung_ajib/services/services.dart';

class ProductRepository {
  final tableName = 'products';

  Future<List<Product>?> getAllProduct() async {
    final db = await DBService.getDatabase();
    final result = await db.query(tableName, columns: [
      'id',
      'name',
      'description',
      'price',
      'image',
    ]);
    db.close();

    if (result.isNotEmpty) {
      return result.map((productMap) => Product.fromMap(productMap)).toList();
    } else {
      return null;
    }
  }
}
