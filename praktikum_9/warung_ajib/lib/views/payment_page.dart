import 'package:flutter/material.dart';
import 'package:warung_ajib/models/product.dart';

class PaymentPage extends StatelessWidget {
  final int? totalTransaction;
  final Map<Product, int>? productQuantityMap;
  final VoidCallback? onPaymentComplete;

  const PaymentPage({
    super.key,
    this.totalTransaction,
    this.productQuantityMap,
    this.onPaymentComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Daftar Produk:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: productQuantityMap!.entries
                    .where((entry) => entry.value > 0)
                    .map((entry) => ListTile(
                          title: Text(entry.key.name),
                          subtitle: Text('Jumlah: ${entry.value}'),
                          trailing: Text('Rp. ${entry.key.price * entry.value}'),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Total Transaksi:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Rp. $totalTransaction',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Pembayaran'),
                    content: const Text('Apakah Anda yakin ingin melakukan pembayaran?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Ya'),
                      ),
                    ],
                  ),
                );

                if (result == true) {
                  onPaymentComplete!();
                  Navigator.pop(context);
                }
              },
              child: const Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
