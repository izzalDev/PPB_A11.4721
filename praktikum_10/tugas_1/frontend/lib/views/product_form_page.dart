import 'package:flutter/material.dart';
import 'package:tugas_1/models/models.dart';
import 'package:tugas_1/repositories/repositories.dart';
import 'package:tugas_1/widgets/widgets.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late final Map<String, TextEditingController> _controllers;
  late final ProductRepository _productRepository;
  late final bool _isEditMode;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _productRepository = ProductRepository.instance;
    _initializeControllers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _product = ModalRoute.of(context)?.settings.arguments as Product?;
    if (_product != null) {
      _isEditMode = true;
      _populateControllers();
    } else {
      _isEditMode = false;
    }
  }

  void _initializeControllers() {
    _controllers = {
      'name': TextEditingController(),
      'purchasePrice': TextEditingController(),
      'sellingPrice': TextEditingController(),
      'stock': TextEditingController(),
    };
  }

  void _populateControllers() {
    _controllers['name']?.text = _product!.name;
    _controllers['purchasePrice']?.text = _product!.purchasePrice.toString();
    _controllers['sellingPrice']?.text = _product!.sellingPrice.toString();
    _controllers['stock']?.text = _product!.stock.toString();
  }

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _onSaveButtonPressed() async {
    _product = Product(
      id: _product?.id,
      name: _controllers['name']!.text,
      purchasePrice: int.parse(_controllers['purchasePrice']!.text),
      sellingPrice: int.parse(_controllers['sellingPrice']!.text),
      stock: int.parse(_controllers['stock']!.text),
    );

    try {
      if (_isEditMode) {
        await _productRepository.update(_product!);
        _showSnackbar('Produk berhasil diperbarui!');
      } else {
        await _productRepository.create(_product!);
        _showSnackbar('Produk berhasil ditambahkan!');
      }
      Navigator.pop(context);
    } catch (e) {
      _showSnackbar('Error: $e', isSuccess: false);
      rethrow;
    }
  }

  void _showSnackbar(String message, {bool isSuccess = true}) {
    CustomSnackBar.show(
      context: context,
      message: message,
      isSuccess: isSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? "Edit Produk" : "Tambah Produk"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllers['name'],
              decoration: const InputDecoration(
                labelText: "Nama Produk",
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controllers['purchasePrice'],
              decoration: const InputDecoration(
                labelText: "Harga Pembelian",
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controllers['sellingPrice'],
              decoration: const InputDecoration(
                labelText: "Harga Jual",
                border: OutlineInputBorder(),
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controllers['stock'],
              decoration: const InputDecoration(
                labelText: "Stok",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('save-button'),
              onPressed: _onSaveButtonPressed,
              child: Text(_isEditMode ? "Perbarui" : "Buat"),
            ),
          ],
        ),
      ),
    );
  }
}
