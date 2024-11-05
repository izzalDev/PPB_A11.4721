import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'success_page.dart'; // Import halaman sukses

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString(_usernameController.text);

    if (storedPassword == null) {
      _message = 'User tidak ada. Silakan buat akun.';
    } else if (storedPassword == _passwordController.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    } else {
      _message = 'Password salah. Silakan coba lagi.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Buat Akun'),
            ),
            const SizedBox(height: 20),
            Text(_message, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
