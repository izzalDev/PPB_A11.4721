import 'package:flutter/material.dart';
import 'package:menu_makanan/menu.dart';
import 'package:menu_makanan/menu_page.dart';

//ignore: must_be_immutable
class NotaPage extends StatelessWidget {
  NotaPage({super.key, required this.pesanan, required this.jumlah});
  Menu pesanan;
  int jumlah;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nota Anda")),
        body: Column(
          children: [
            const Text("Pemesanan"),
            Text(pesanan.nama),
            Text("${pesanan.harga} x $jumlah"),
            const Text("Berhasil Disimpan"),
            const Text("Total Bayar:"),
            Text((pesanan.harga * jumlah).toString()),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MenuPage()),
                      (Route<dynamic> r) => false);
                },
                child: const Text("Kembali ke Menu"))
          ],
        ));
  }
}
