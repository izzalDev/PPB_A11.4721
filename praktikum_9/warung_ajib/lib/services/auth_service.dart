import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:warung_ajib/repositories/repositories.dart';
import 'package:warung_ajib/models/models.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final UserRepository _userRepository = UserRepository();
  User? _currentUser;

  User? get currentUser => _currentUser;

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> login(String username, String password) async {
    final hashedPassword = _hashPassword(password);
    final user = await _userRepository.getUserByUsername(username);

    if (user != null && user.password == hashedPassword) {
      _currentUser = user;
      return true;
    }

    return false;
  }

  Future<bool> register(
    String fullname,
    String username,
    String password,
  ) async {
    final existingUser = await _userRepository.getUserByUsername(username);
    if (existingUser != null) return false;

    final newUser = User(
      fullname: fullname,
      username: username,
      password: _hashPassword(password),
    );

    await _userRepository.addUser(newUser);
    _currentUser = newUser;

    return true;
  }

  bool logout() {
    _currentUser = null;
    return true;
  }

  bool isLoggedIn() {
    return _currentUser != null;
  }
}
