import 'package:flutter/material.dart';

void main() {
  runApp(const PPBApp());
}

class PPBApp extends StatelessWidget {
  const PPBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PPB Calculator',
      home: PPBHomePage(),
    );
  }
}

class PPBHomePage extends StatefulWidget {
  const PPBHomePage({super.key});

  @override
  _PPBHomePageState createState() => _PPBHomePageState();
}

class _PPBHomePageState extends State<PPBHomePage> {
  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nilaiUtsController = TextEditingController();
  final TextEditingController nilaiTugasController = TextEditingController();
  final TextEditingController nilaiUasController = TextEditingController();
  
  String? hasil;

  void hitung() {
    final nim = nimController.text;
    final nama = namaController.text;
    final nilaiUts = double.tryParse(nilaiUtsController.text) ?? 0.0;
    final nilaiTugas = double.tryParse(nilaiTugasController.text) ?? 0.0;
    final nilaiUas = double.tryParse(nilaiUasController.text) ?? 0.0;

    // Menghitung nilai akhir berdasarkan bobot
    double nilaiAkhir = (nilaiUts * 0.3) + (nilaiTugas * 0.35) + (nilaiUas * 0.35);
    
    // Mendapatkan nilai huruf dan predikat
    String nilaiHuruf;
    String predikat;

    if (nilaiAkhir >= 85) {
      nilaiHuruf = 'A';
      predikat = 'Sangat Baik';
    } else if (nilaiAkhir >= 70) {
      nilaiHuruf = 'B';
      predikat = 'Baik';
    } else if (nilaiAkhir >= 60) {
      nilaiHuruf = 'C';
      predikat = 'Cukup';
    } else if (nilaiAkhir >= 50) {
      nilaiHuruf = 'D';
      predikat = 'Kurang';
    } else {
      nilaiHuruf = 'E';
      predikat = 'Buruk';
    }

    setState(() {
      hasil = 'NIM: $nim\n'
              'Nama: $nama\n'
              'Nilai Akhir: $nilaiAkhir\n'
              'Nilai Huruf: $nilaiHuruf\n'
              'Predikat: $predikat';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PPB Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nimController,
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: nilaiUtsController,
              decoration: const InputDecoration(labelText: 'Nilai UTS'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nilaiTugasController,
              decoration: const InputDecoration(labelText: 'Nilai Tugas'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: nilaiUasController,
              decoration: const InputDecoration(labelText: 'Nilai UAS'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hitung,
              child: const Text('Hitung Nilai'),
            ),
            const SizedBox(height: 20),
            if (hasil != null) ...[
              Text(hasil!, style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
