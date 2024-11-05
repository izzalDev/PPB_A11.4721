import 'package:flutter/material.dart';
import 'package:ayamku/menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late List<Menu> listMenu;
  int totalHarga = 0; // Variabel untuk menyimpan total harga

  @override
  void initState() {
    super.initState();
    listMenu = _initializeMenu();
  }

  List<Menu> _initializeMenu() {
    return [
      Menu(
        nama: 'Ayam Betutu',
        deskripsi:
            "Olahan ayam khas Gilimanuk, Bali. Olahan pedas ini pasti akan memanjakan lidahmu dengan bumbu kuning yang lezat.",
        harga: 20000,
        gambar: 'ayam_betutu.jpg',
      ),
      Menu(
        nama: "Ayam Taliwang",
        deskripsi:
            "Ayam Taliwang adalah makanan khas Taliwang, Sumbawa Barat, Nusa Tenggara Barat.",
        harga: 15000,
        gambar: 'ayam_taliwang.jpg',
      ),
      Menu(
        nama: "Pepes Ayam",
        deskripsi:
            "Olahan ayam khas Sunda ini sangat pas nikmat disajikan dengan sepiring nasi putih hangat.",
        harga: 18000,
        gambar: 'pepes_ayam.jpg',
      ),
      Menu(
        nama: "Ayam Bumbu Kemangi",
        deskripsi:
            "Aroma kemangi yang khas akan membuat masakan ini semakin nikmat.",
        harga: 25000,
        gambar: 'ayam_bumbu_kemangi.jpg',
      ),
      Menu(
        nama: "Ayam Rica-Rica",
        deskripsi: "Ayam juga nikmat dimasak rica-rica.",
        harga: 30000,
        gambar: 'ayam_rica_rica.jpg',
      ),
      Menu(
        nama: "Ayam Panggang",
        deskripsi: "Ayam panggang bisa kamu beli di banyak tempat makan.",
        harga: 30000,
        gambar: "ayam_panggang.jpg",
      ),
    ];
  }

  void _tambahKeTotal(int harga) {
    setState(() {
      totalHarga += harga; // Tambahkan harga menu ke total
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplikasi Menu Makanan')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Pilih Menu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, // Mengatur aspect ratio untuk card
              ),
              itemCount: listMenu.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildMenuCard(context, listMenu[index]);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Total: Rp. $totalHarga", // Tampilkan total di bagian bawah layar
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Menu menu) {
    return GestureDetector(
      onTap: () {
        _tambahKeTotal(
            menu.harga); // Tambahkan harga menu ke total saat di-klik
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/images/${menu.gambar}',
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.nama,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menu.deskripsi,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      "Rp. ${menu.harga}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
