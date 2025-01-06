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

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final isPasswordValid = await validatePassword(currentPassword);
    final hashedPassword = _hashPassword(newPassword);

    if (isPasswordValid) {
      _currentUser?.password = hashedPassword;
      _userRepository.updateUser(_currentUser!);
      return true;
    }

    return false;
  }

  Future<bool> updateUsername(
    String currentPassword,
    String newUsername,
  ) async {
    final isPasswordValid = await validatePassword(currentPassword);

    if (isPasswordValid) {
      _currentUser?.username = newUsername;
      _userRepository.updateUser(_currentUser!);
      return true;
    }

    return false;
  }

  Future<bool> validatePassword(String currentPassword) async {
    final hashedPassword = _hashPassword(currentPassword);

    if (_currentUser?.password == hashedPassword) {
      return true;
    } else {
      return false;
    }
  }
}
