import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';

class ProductFormPage extends StatelessWidget {
  final Product product;

  const ProductFormPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Data berhasil dikirim, ${product.name}'),
      ),
    );
  }
}
