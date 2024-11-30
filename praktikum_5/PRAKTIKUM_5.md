---
title: "PRAKTIKUM_5"
toc: true
toc-own-page: true
toc-title: "Daftar Isi"
titlepage: true
author: " - "
header-includes:
  - \usepackage{caption}
  - \captionsetup[figure]{name=Screenshot, justification=centering, singlelinecheck=false}
---
# PROFIL_RESTO
## lib/main.dart
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RestaurantProfile(),
    );
  }
}

class RestaurantProfile extends StatelessWidget {
  const RestaurantProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rm. Sedap Rasa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Profil
            Center(
              child: Container(
                width: double.infinity,
                color: Colors.grey,
                child: Image.asset("assets/images/gambar.jpg"),
              ),
            ),
            const SizedBox(height: 10),
            
            // Ikon kontak
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Icon(Icons.location_on),
                SizedBox(width: 10),
                Icon(Icons.phone),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Deskripsi
            const Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Restoran kami menyajikan makanan lezat dan sehat..."),
            
            const SizedBox(height: 20),
            
            // List Menu
            const Text("List Menu:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Column(
              children: [
                Text("• Nasi Goreng"),
                Text("• Ayam Bakar"),
                Text("• Sate Ayam"),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Alamat
            const Text("Alamat:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Jl. Contoh No. 123, Kota"),
            
            const SizedBox(height: 20),
            
            // Jam Buka
            const Text("Jam Buka:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Column(
              children: [
                Text("Senin - Jumat: 08:00 - 22:00"),
                Text("Sabtu - Minggu: 10:00 - 23:00"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

```
## screenshot
\clearpage
# PENGHITUNG_BBM
## lib/bbm.dart
```dart
class BBM {
  String nama;
  int harga;
  BBM({required this.nama, required this.harga});
  @override
  String toString() {
    return "$nama : $harga";
  }
}

```
## lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:penghitung_bbm/bbm.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Kalkulator BBM",
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _MainHomePage();
}

class _MainHomePage extends State<MainHomePage> {
  var listBbm = <BBM>[
    BBM(nama: 'Premium', harga: 10000),
    BBM(nama: 'Pertamax', harga: 14000),
    BBM(nama: 'Pertamax Turbo', harga: 16600),
    BBM(nama: 'Solar', harga: 6800),
  ];
  TextEditingController tujuanCtrl = TextEditingController();
  TextEditingController jarakCtrl = TextEditingController();
  String textHasil = '';
  BBM? selectedBBM;
  _MainHomePage() {
    selectedBBM = listBbm[0];
  }
  void setHasil() {
    double biaya = selectedBBM!.harga * (int.parse(jarakCtrl.text) / 10);
    setState(() {
      textHasil = biaya.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator BBM"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 30),
              child: const Center(
                child: Text(
                  'Hitung BBM & Biaya',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Text("Nama Tujuan"),
            TextField(controller: tujuanCtrl),
            const SizedBox(height: 20),
            const Text("Jarak Tempuh"),
            TextField(controller: jarakCtrl),
            const SizedBox(height: 20),
            const Text("Pilihan BBM"),
            DropdownButton<BBM>(
                isExpanded: true,
                value: selectedBBM,
                items: listBbm.map((BBM item) {
                  return DropdownMenuItem<BBM>(
                      value: item, child: Text(item.toString()));
                }).toList(),
                onChanged: (BBM? newVal) {
                  setState(() {
                    selectedBBM = newVal;
                  });
                }),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: setHasil, child: const Text("Hitung BBM"))),
            Text(textHasil)
          ],
        ),
      ),
    );
  }
}

```
## screenshot
\clearpage
