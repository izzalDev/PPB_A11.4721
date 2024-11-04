import 'kamera.dart';
import 'radio.dart';
import 'telepon.dart';


class Handphone extends Telepon implements Kamera, Radio {
  String gelombang = '';
  double pixel = 0;
  @override
  void ambilGambar() {
    print("Gambar terambil...: $pixel");
  }


  void setGelombang(String gel) {
    this.gelombang = gel;
      }


  void setPixel(double pixel) {
    this.pixel = pixel;
  }


  void setNomor(int no) {
    this.nomer = no;
  }
}
