import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsPage extends StatelessWidget {
  final String phoneNumber = '081234567890'; // Ganti dengan nomor telepon penjual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS ke Penjual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kirim SMS ke Penjual',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Jika Anda ingin menghubungi penjual melalui SMS, silakan tekan tombol di bawah ini:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              phoneNumber,
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _sendSms(phoneNumber),
              child: const Text('Kirim SMS'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
