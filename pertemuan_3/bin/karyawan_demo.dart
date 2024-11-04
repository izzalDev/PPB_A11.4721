import "karyawan.dart";

void main(List<String> arguments) {
  Karyawan staff1 = Karyawan(npp: "A123456", nama: "Paijo"); // object
  Karyawan staff2 = Karyawan(npp: "B234567", nama: "Dinda", thnMasuk: 2020);
  staff1.presensi(DateTime.parse("2024-10-01 08:30:07"));
  staff2.presensi(DateTime.parse("2024-10-01 08:01:03"));
  print(staff1.deskripsi());
  print(staff2.deskripsi());
  List<Karyawan> dataStaf = [];
  dataStaf.add(Karyawan(npp: "A123456", nama: "Daniswara"));
  dataStaf.add(Karyawan(npp: "B123456", nama: "Nina"));
  dataStaf.add(Karyawan(npp: "C123456", nama: "Bocil"));
  for (Karyawan staf in dataStaf) {
    staf.deskripsi();
  }
}
