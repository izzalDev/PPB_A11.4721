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
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      print(data.map((json) => Product.fromMap(json)).toList());
      return data.map((json) => Product.fromMap(json)).toList();
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to load products: $error');
    }
  }

  Future<Product> getById(int id) async {
    final response = await http.get(baseUrl.resolve('/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromMap(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to load products: $error');
    }
  }

  Future<Product> create(Product product) async {
    final response = await http.post(
      baseUrl.resolve('/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toMap()),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return Product.fromMap(body['data']);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to load products: $error');
    }
  }

  Future<Product> update(Product product) async {
    final response = await http.put(
      baseUrl.resolve('/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toMap()),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Product.fromMap(body['data']);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to load products: $error');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(
      baseUrl.resolve('/products/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['error'];
      throw Exception('Failed to load products: $error');
    }
  }
}
