import 'handphone.dart';

void main() {
  Handphone hp = Handphone();
  hp.setPixel(4080);
  hp.ambilGambar();
  hp.setNomor(81917161);
  hp.setGelombang('Fm 120.5');
  String st = hp.gelombang;
  print('Demgar Radio : $st');
  hp.telpon();
}
