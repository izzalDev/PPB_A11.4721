import 'package:flutter/material.dart';
import 'package:warung_ajib/services/services.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({super.key});

  @override
  _UserUpdatePageState createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final _usernameController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final auth = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _usernameController.text = auth.currentUser?.username ?? '';
    });
  }

  Future<void> _updateUserInfoAndPassword() async {
    String currentUser = _usernameController.text;
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;

    // Validasi apakah semua field telah diisi
    if (currentUser.isEmpty || currentPassword.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field harus diisi!')),
      );
      return;
    }

    try {
      // Validasi password sekarang
      bool isPasswordValid = await auth.validatePassword(currentPassword);

      if (isPasswordValid) {
        // Update password dan username
        await auth.changePassword(currentPassword, newPassword);
        await auth.updateUsername(currentPassword, currentUser);

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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
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
                controller: _usernameController,
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
