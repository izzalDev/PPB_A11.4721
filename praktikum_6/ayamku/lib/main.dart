import 'package:flutter/material.dart';
import 'package:ayamku/menu_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Aplikasi Pemesanan Makanan",
      home: MenuPage(),
    );
  }
}