import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterPage extends StatelessWidget {
  final String phoneNumber = '081234567890'; // Ganti dengan nomor telepon penjual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Center Penjual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hubungi Call Center Kami',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Jika Anda memiliki pertanyaan atau masalah, silakan hubungi kami di:',
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
              onPressed: () => _makePhoneCall(phoneNumber),
              child: const Text('Hubungi Sekarang'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
