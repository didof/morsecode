import 'package:lamp/lamp.dart';

abstract class LampInterfaceContract {
  Future<bool> hasLamp();

  void lightOn();

  void lightOff();
}

class LampInterfaceImpl implements LampInterfaceContract {
  @override
  Future<bool> hasLamp() async {
    return await Lamp.hasLamp;
  }

  void lightOn() {
    Lamp.turnOn();
  }

  void lightOff() {
    Lamp.turnOff();
  }
}
