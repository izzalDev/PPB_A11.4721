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
        '/call-center': (context) => const CallCenterPage(),
        '/maps': (context) => const MapsPage(),
        '/payment': (context) => const PaymentPage(),
        '/sms': (context) => const SmsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/payment') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => PaymentPage(
              totalTransaction: args['totalTransaction'],
              productQuantityMap: args['productQuantityMap'],
              onPaymentComplete: args['onPaymentComplete'],
            ),
          );
        }
        return null; // Default fallback
      },
    );
  }
}
