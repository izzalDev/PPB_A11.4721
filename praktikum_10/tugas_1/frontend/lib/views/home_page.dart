import 'package:flutter/material.dart';
import 'package:tugas_1/models/models.dart';
import 'package:tugas_1/repositories/repositories.dart';
import 'package:tugas_1/views/views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ProductRepository _productRepository;
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository.instance;
    _productsFuture = _productRepository.getAll();
  }

  void _addNewProduct() async {
    await Navigator.pushNamed(context, '/productFormPage');
    setState(() {
      _productsFuture = _productRepository.getAll();
    });
  }

  void _editProduct(Product product) async {
    await Navigator.pushNamed(context, '/productFormPage', arguments: product);
    setState(() {
      _productsFuture = _productRepository.getAll();
    });
  }

  void _showBottomSheet(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop();
                  _editProduct(product);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog() {}

  Widget _buildCard(Product product) {
    return GestureDetector(
      onLongPress: () {
        _showBottomSheet(product);
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Harga Beli: Rp${product.purchasePrice}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Harga Jual: Rp${product.sellingPrice}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Stok: ${product.stock} unit",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Inventory App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isNotEmpty) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) => _buildCard(products[index]),
            );
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
