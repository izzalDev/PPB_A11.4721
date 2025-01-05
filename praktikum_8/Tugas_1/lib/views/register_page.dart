import 'package:flutter/material.dart';
import 'package:tugas_1/services/services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  void _registerButtonAction() async {
    final fullname = fullnameController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final success = await auth.register(fullname, username, password);

    if (success && mounted) {
      _showSnackBar(content: 'Registrasi berhasil. Mengalihkan ke halaman home.');
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      _showSnackBar(content: 'Register gagal.');
    }
  }

  void _loginButtonAction() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showSnackBar({required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Fullname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _registerButtonAction,
                child: const Text('Daftar'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _loginButtonAction,
                child: const Text('Sudah punya akun? Login!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
