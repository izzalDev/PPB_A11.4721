class Karyawan {
  String npp;
  String nama;
  String? alamat;
  int thnMasuk;
  final int _gaji = 2900000;

  Karyawan({required this.npp, required this.nama, this.thnMasuk = 2015});
  void presensi(DateTime jamMasuk) {
    if (jamMasuk.hour > 8) {
      print("$nama datang terlambat");
    } else {
      print("$nama datang tepat waktu");
    }
  }

  String deskripsi() {
    String teks = """=================================
NPP: $npp
Nama: $nama
Gaji: $_gaji;
""";
    return teks;
  }
}
