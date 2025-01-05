import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/repositories/repositories.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;
  final VoidCallback onSave;

  const ProductFormPage({super.key, this.product, required this.onSave});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final nameController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final stockController = TextEditingController();
  final productRepository = ProductRepository();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      purchasePriceController.text = widget.product!.purchasePrice.toString();
      sellingPriceController.text = widget.product!.sellingPrice.toString();
      stockController.text = widget.product!.stock.toString();
    }
  }

  void _saveButtonAction() async {
    final name = nameController.text.trim();
    final purchasePrice = int.tryParse(purchasePriceController.text) ?? 0;
    final sellingPrice = int.tryParse(sellingPriceController.text) ?? 0;
    final stock = int.tryParse(stockController.text) ?? 0;

    final product = Product(
      name: name,
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      stock: stock,
      id: widget.product?.id, // Ensure ID is passed correctly (null check)
    );

    final success;
    if (product.id != null) {
      success = await productRepository.updateProduct(product);
    } else {
      success = await productRepository.addProduct(product);
    }

    if (success != null && mounted) {
      widget.onSave(); // Call onSave callback to refresh the list
      Navigator.of(context).pop();
    } else {
      _showSnackBar(content: 'Gagal menyimpan produk.');
    }
  }

  void _showSnackBar({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Edit Barang' : 'Tambah Barang'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: purchasePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Beli',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sellingPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Jual',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveButtonAction,
                child: Text(
                    widget.product != null ? 'Update Barang' : 'Tambah Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
