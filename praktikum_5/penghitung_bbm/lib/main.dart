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
