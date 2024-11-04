// pegawai.dart
import 'package:intl/intl.dart';

// Konstanta untuk gaji minimum
const int umr = 2900000;

// Enum untuk tipe jabatan
enum TipeJabatan { kabag, manajer, direktur }

// Formatter untuk angka dan tanggal
final formater = NumberFormat("#,000");
final dateFormater = DateFormat('yyyy-MM-dd');

// Kelas abstrak Staff
abstract class Staff {
  String npp;
  String nama;
  String? alamat;
  int thnMasuk;
  int _gaji = umr;

  // Konstruktor
  Staff(this.npp, this.nama, {this.thnMasuk = 2015, this.alamat});

  // Getter abstrak untuk tunjangan
  int get tunjangan;

  // Setter untuk gaji dengan validasi
  set gaji(int gaji) {
    if (gaji < umr) {
      _gaji = umr;
      print('Gaji tidak boleh di bawah UMR');
    } else if ((2023 - thnMasuk) < 5 && gaji != umr) {
      _gaji = umr;
      print('Gaji pegawai baru harus sesuai UMR');
    } else {
      _gaji = gaji;
    }
  }

  // Getter untuk total gaji (gaji pokok + tunjangan)
  int get gaji => _gaji + tunjangan;

  // Metode abstrak
  String deskripsi();
  void absenMasuk(DateTime jamMasuk);

  // Factory method untuk pembuatan objek dari Map
  factory Staff.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('jabatan')) {
      return Pejabat(
        data['npp'],
        data['nama'],
        TipeJabatan.values.byName(data['jabatan']),
        thnMasuk: data['thn_masuk'] ?? 2015,
        alamat: data['alamat'],
      );
    } else {
      return Karyawan(
        data['npp'],
        data['nama'],
        thnMasuk: data['thn_masuk'] ?? 2015,
        alamat: data['alamat'],
      );
    }
  }
}

// Kelas Karyawan
class Karyawan extends Staff {
  Karyawan(super.npp, super.nama, {super.thnMasuk = 2015, super.alamat});

  @override
  void absenMasuk(DateTime jamMasuk) {
    String status = jamMasuk.hour > 8 ? "Terlambat" : "Tepat waktu";
    print('$nama pada ${dateFormater.format(jamMasuk)} datang $status');
  }

  @override
  int get tunjangan => (2023 - thnMasuk) < 5 ? 1000000 : 2000000;

  @override
  String deskripsi() {
    return '''
====================
NPP       : $npp 
Nama      : $nama 
Gaji      : ${formater.format(gaji)}
${alamat != null ? 'Alamat    : $alamat' : ''}
====================
''';
  }
}

// Kelas Pejabat
class Pejabat extends Staff {
  TipeJabatan jabatan;

  Pejabat(super.npp, super.nama, this.jabatan, {super.thnMasuk = 2015, super.alamat});

  @override
  void absenMasuk(DateTime jamMasuk) {
    String status = jamMasuk.hour > 9 ? "Terlambat" : "Tepat waktu";
    print('$nama pada ${dateFormater.format(jamMasuk)} datang $status');
  }

  @override
  int get tunjangan {
    switch (jabatan) {
      case TipeJabatan.kabag:
        return 10000000;
      case TipeJabatan.manajer:
        return 15000000;
      case TipeJabatan.direktur:
        return 20000000;
      default:
        return 0;
    }
  }

  @override
  String deskripsi() {
    return '''
====================
NPP       : $npp 
Nama      : $nama 
Jabatan   : ${jabatan.name}
Gaji      : ${formater.format(gaji)}
${alamat != null ? 'Alamat    : $alamat' : ''}
====================
''';
  }
}
