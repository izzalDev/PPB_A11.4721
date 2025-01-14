import 'package:flutter/material.dart';
import 'package:tugas_1/models/models.dart';
import 'package:tugas_1/repositories/repositories.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ProductRepository _productRepository;
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository.instance;
    _productsFuture = _productRepository.getAll();
  }

  void _addNewProduct() {}

  void _editProduct() {}

  void _deleteProduct() {}

  void _showBottomSheet() {}

  void _showDeleteDialog() {}

  Widget _buildCard(Product product) {
    return const Text('Implement Here');
  }

  List<Widget> _buildBodyChildren() {
    return [
      const Text(
        'You have pushed the button this many times:',
      ),
      _buildCard(Product(
        name: 'barang',
        purchasePrice: 20000,
        sellingPrice: 20000,
        stock: 20000,
      )),
    ];
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBodyChildren(),
        ),
      ),
    );
  }
}
