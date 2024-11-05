import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Agen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'UMKM Warung Ajib',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bandungrejo, Mranggen, Demak',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Untuk informasi lebih lanjut, hubungi agen terdekat atau kunjungi langsung lokasi kami.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
              onPressed: ()=>{
                MapsLauncher.launchQuery('Bandungrejo, Mranggen, Demak')
              },
              child: const Text('Buka Maps'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
