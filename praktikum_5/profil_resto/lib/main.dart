import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RestaurantProfile(),
    );
  }
}

class RestaurantProfile extends StatelessWidget {
  const RestaurantProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rm. Sedap Rasa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Profil
            Center(
              child: Container(
                width: double.infinity,
                color: Colors.grey,
                child: Image.asset("assets/images/gambar.jpg"),
              ),
            ),
            const SizedBox(height: 10),
            
            // Ikon kontak
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                SizedBox(width: 10),
                Icon(Icons.location_on),
                SizedBox(width: 10),
                Icon(Icons.phone),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Deskripsi
            const Text("Deskripsi:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Restoran kami menyajikan makanan lezat dan sehat..."),
            
            const SizedBox(height: 20),
            
            // List Menu
            const Text("List Menu:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Column(
              children: [
                Text("• Nasi Goreng"),
                Text("• Ayam Bakar"),
                Text("• Sate Ayam"),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Alamat
            const Text("Alamat:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Jl. Contoh No. 123, Kota"),
            
            const SizedBox(height: 20),
            
            // Jam Buka
            const Text("Jam Buka:", style: TextStyle(fontWeight: FontWeight.bold)),
            const Column(
              children: [
                Text("Senin - Jumat: 08:00 - 22:00"),
                Text("Sabtu - Minggu: 10:00 - 23:00"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
