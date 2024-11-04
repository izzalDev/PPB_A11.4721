class Bicycle {
  int speed = 0;
  int gear = 0;


  void changeGear(int newValue) {
    gear = gear + newValue;
    print("Gear: $gear");
  }


  void speedUp(int increment) {
    speed = speed + increment;
    print("Speed: $speed");
  }
}


class MountainBike extends Bicycle {
  int seatHeight = 0;


  void setHeight(int newHeight) {
    seatHeight = newHeight;
    print("Seat Height: $seatHeight");
  }
}