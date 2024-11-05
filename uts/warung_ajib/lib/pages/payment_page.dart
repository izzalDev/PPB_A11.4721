import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final int totalTransaction;

  const PaymentPage({super.key, required this.totalTransaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            const Center(
              child: Text(
                'Jumlah Pembayaran:',
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
            const Center(
              child: Text(
                'Kembali:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                'Rp. 0',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
