import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _createUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString(_usernameController.text);

    if (storedPassword == null) {
      await prefs.setString(_usernameController.text, _passwordController.text);
      _message = 'Akun berhasil dibuat!';
    } else {
      _message = 'Username sudah terdaftar.';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Akun')),
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
              onPressed: _createUser,
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
