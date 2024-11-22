import 'package:flutter/material.dart';
import 'package:inventory_app/views/views.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/product_form_page': (context) => const ProductFormPage(),
      },
    );
  }
}
