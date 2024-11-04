// pegawai_demo.dart
import 'pegawai.dart';

void main(List<String> arguments) {
  // Buat data pegawai dari dummyData
  List<Staff> dataPegawai = dummyData().map((data) => Staff.fromMap(data)).toList();

  // Tampilkan deskripsi masing-masing pegawai
  for (final pegawai in dataPegawai) {
    print(pegawai.deskripsi());
  }

  // Coba absen untuk pegawai tertentu
  dataPegawai[2].absenMasuk(DateTime.parse('2023-08-01 09:00:08'));
}

// Data dummy untuk testing
List<Map<String, dynamic>> dummyData() {
  return [
    {
      "npp": "A123",
      "nama": "Lars Bak",
      "thn_masuk": 2017,
      "jabatan": "direktur",
      "alamat": "Semarang, Indonesia"
    },
    {
      "npp": "A345",
      "nama": "Kasper Lund",
      "thn_masuk": 2018,
      "jabatan": "manajer",
      "alamat": "Semarang, Indonesia"
    },
    {
      "npp": "B231",
      "nama": "Guido Van Rossum",
      "alamat": "California, Amerika"
    },
    {
      "npp": "B355",
      "nama": "Rasmus Lerdorf",
      "thn_masuk": 2015,
      "alamat": "Bandung, Indonesia"
    },
    {
      "npp": "B400",
      "nama": "Dennis Ritchie",
      "jabatan": "kabag",
      "alamat": "Bandung, Indonesia"
    },
  ];
}
