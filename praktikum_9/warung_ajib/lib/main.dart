import 'package:flutter/material.dart';
import 'package:warung_ajib/splashscreen.dart';
import 'package:warung_ajib/views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash-screen',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/splash-screen': (context) => const SplashScreen(),
        '/user-update': (context) => const UserUpdatePage(),
      },
    );
  }
}
