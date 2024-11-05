import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Berhasil')),
      body: const Center(
        child: Text(
          'Login Berhasil!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
