import 'package:flutter/material.dart';
import 'package:tugas_1/services/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final auth = AuthService();

  void _logoutButtonAction() {
    final success = auth.logout();
    if (success) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Selamat datang ${auth.currentUser!.fullname}, Ini halaman home'),
            ElevatedButton(
              onPressed: _logoutButtonAction,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
