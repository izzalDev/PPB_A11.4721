import 'package:flutter/material.dart';
import 'package:tugas_1/services/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  void _loginButtonAction() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final success = await auth.login(username, password);

    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      _showSnackBar(content: 'Login gagal. Periksa kembali kredensial Anda.');
    }
  }

  void _registerButtonAction() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _showSnackBar({required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Login'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                onPressed: _loginButtonAction,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _registerButtonAction,
                child: const Text('Belum Punya Akun? Daftar!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
