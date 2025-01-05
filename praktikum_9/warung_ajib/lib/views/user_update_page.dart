import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({super.key});

  @override
  _UserUpdatePageState createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final _nameController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('currentUser') ?? '';
    });
  }

  Future<void> _updateUserInfoAndPassword() async {
    final prefs = await SharedPreferences.getInstance();
    String currentUser = _nameController.text;
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    // Validasi dan perbarui password
    String? storedPassword = prefs.getString(currentUser);
    if (storedPassword != null && storedPassword == currentPassword) {
      await prefs.setString('userPassword', newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Informasi pengguna dan password berhasil diperbarui!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password sekarang salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User & Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _currentPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Password Sekarang'),
                obscureText: true,
              ),
              TextField(
                controller: _newPasswordController,
                decoration: const InputDecoration(labelText: 'Password Baru'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUserInfoAndPassword,
                child: const Text('Update'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
