import 'package:flutter/material.dart';
import 'package:tugas_1/models/models.dart';
import 'package:tugas_1/repositories/repositories.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _productRepository = ProductRepository();
  late Future<List<Product>> _productsFuture;

  void _addNewProduct() {}

  void _editProduct() {}

  void _deleteProduct() {}

  void _showBottomSheet() {}

  void _showDeleteDialog() {}

  void _buildCard() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Inventory App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Halo Dunia',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewProduct,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
