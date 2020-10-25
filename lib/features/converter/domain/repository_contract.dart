import 'package:meta/meta.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';

enum LampState {
  on,
  off,
}

abstract class ConverterRepositoryContract {
  Future<bool> checkIfHasLamp();

  LampState setLampState({@required LampState newLampState});

  LampState invertLampState({@required LampState currentLampState});

  Mc instantiateMcEntity({String word, List<String> morsecode});

  Stream<LampState> playLampStream({@required Stream<bool> lampStream});
}
