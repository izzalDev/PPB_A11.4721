import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:latihan_web_service/views/views.dart';

void main() async {
  await initializeDateFormatting('id_ID');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
