import 'package:tugas_1/config.dart';

class ProductRepository {
  final Uri apiBaseUrl;

  ProductRepository._({required this.apiBaseUrl});

  static final ProductRepository _instance = ProductRepository._(
    apiBaseUrl: Config.apiBaseUrl,
  );

  factory ProductRepository() {
    return _instance;
  }

  getAll() {}

  getById() {}

  create() {}

  updateById() {}

  deleteById() {}
}
