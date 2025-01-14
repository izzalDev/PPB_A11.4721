import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugas_1/config.dart';
import 'package:tugas_1/models/models.dart';

class ProductRepository {
  static final ProductRepository instance = ProductRepository._();
  final Uri baseUrl = Config.apiBaseUrl;

  ProductRepository._();

  Future<List<Product>> getAll() async {
    final response = await http.get(baseUrl.resolve('/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> getById(int id) async {
    final response = await http.get(baseUrl.resolve('/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<Product> create(Product product) async {
    final response = await http.post(
      baseUrl.resolve('/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toMap()),
    );

    if (response.statusCode == 201) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }

  Future<Product> update(Product product) async {
    final response = await http.put(
      baseUrl.resolve('/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toMap()),
    );

    if (response.statusCode == 200) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(baseUrl.resolve('/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}

