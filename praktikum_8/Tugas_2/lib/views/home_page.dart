import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/repositories/repositories.dart';
import 'package:inventory_app/views/views.dart';

class HomePage extends StatelessWidget {
  final productRepository = ProductRepository();

  HomePage({super.key});

  void _updateProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = Product(
      name: 'Barang 1',
      purchasePrice: 10,
      sellingPrice: 10,
      stock: 10,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory App')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _updateProduct(context, product),
        tooltip: 'Tambah Barang',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>?>(
        future: productRepository.getAllProduct(),
        builder: (context, snapshot) {
          final connection = snapshot.connectionState;
          if (connection == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final currentProduct = products.elementAt(index);
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            currentProduct.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentProduct.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('ID: ${currentProduct.id}'),
                              Text(
                                  'Purchase Price: ${currentProduct.purchasePrice}'),
                              Text(
                                  'Selling Price: ${currentProduct.sellingPrice}'),
                              Text('Stock: ${currentProduct.stock}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _updateProduct(context, currentProduct),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Tidak ada produk tersedia'),
          );
        },
      ),
    );
  }
}
