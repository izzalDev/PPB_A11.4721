---
title: "PPB_A11.4721"
toc: true
toc-own-page: true
toc-title: "Daftar Isi"
titlepage: true
author: " - "
header-includes:
  - \usepackage{caption}
  - \captionsetup[figure]{name=Screenshot, justification=centering, singlelinecheck=false}
---
# PRAKTIKUM_5
## screenshot
\clearpage
# PRAKTIKUM_4
## lib/kalkulator.dart
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "×":
          _output = (num1 * num2).toString();
          break;
        case "÷":
          _output = (num1 / num2).toString();
          break;
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output += buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(buttonText, style: const TextStyle(fontSize: 20.0)),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(output, style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("÷")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("×")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("."), buildButton("0"), buildButton("00"), buildButton("+")]),
              Row(children: [buildButton("C"), buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
}

```
## lib/nilai_ppb.dart
```dart
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

```
## screenshot
\clearpage
# PRAKTIKUM_3
## lib/pertemuan_3.dart
```dart
int calculate() {
  return 6 * 7;
}

```
## screenshot
\clearpage
# DOKUMENTASI
## screenshot
\clearpage
# UTS
## screenshot
\clearpage
# FLUTTER_PLAYGROUND
## lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _openMaps() async {
    final Uri url = Uri(
      scheme: 'comgooglemapurl',
      path: 'maps.google.com',
      queryParameters: {
        'q': 'Es Teh Ajib',
      },
    );

    if (!await launchUrl(url)) {
      // Menampilkan pesan kesalahan jika URL gagal dibuka.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch map.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _openMaps, // Menggunakan referensi fungsi
              child: const Text('Open Maps'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

```
## screenshot
\clearpage
# PRAKTIKUM_6
## screenshot
\clearpage
# PRAKTIKUM_8
## screenshot
\clearpage
# PRAKTIKUM_9
## screenshot
\clearpage
# PRAKTIKUM_7
## screenshot
\clearpage
# .GITHUB
## screenshot
\clearpage
# .GIT
## screenshot
\clearpage
