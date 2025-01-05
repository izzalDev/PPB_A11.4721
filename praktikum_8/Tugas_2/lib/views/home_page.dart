import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/repositories/repositories.dart';
import 'package:inventory_app/views/views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productRepository = ProductRepository();
  late Future<List<Product>?> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _productsFuture = productRepository.getAllProduct();
  }

  void _addProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormPage(
          onSave: () {
            _loadProducts(); // Refresh the list when a product is saved
            setState(() {});
          },
        ),
      ),
    );
  }

  void _updateProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductFormPage(
          product: product,
          onSave: () {
            _loadProducts(); // Refresh the list when a product is updated
            setState(() {});
          },
        ),
      ),
    );
  }

  void _deleteProduct(Product product) async {
    final result = await productRepository.deleteProduct(product);
    if (result != null && result > 0) {
      _loadProducts(); // Refresh the list after deletion
      setState(() {});
      _showSnackBar('Produk berhasil dihapus');
    } else {
      _showSnackBar('Gagal menghapus produk');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory App')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addProduct(context),
        tooltip: 'Tambah Barang',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>?>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                final currentProduct = products[index];
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
                                  'Harga Beli: ${currentProduct.purchasePrice}'),
                              Text(
                                  'Harga Jual: ${currentProduct.sellingPrice}'),
                              Text('Stok: ${currentProduct.stock}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _updateProduct(context, currentProduct),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(currentProduct),
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
