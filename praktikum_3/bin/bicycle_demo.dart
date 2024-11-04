import 'bicycle.dart';


void main() {
  MountainBike mbike = MountainBike();

  mbike.gear = 2;
  mbike.speedUp(12);
  mbike.changeGear(3);
  mbike.setHeight(25);
}