import 'dart:async';

import 'package:meta/meta.dart';
import 'package:morsecode/features/converter/data/interfaces/lamp_interface.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class ConverterRepositoryImpl implements ConverterRepositoryContract {
  final LampInterfaceContract lampInterface;
  ConverterRepositoryImpl({@required this.lampInterface});

  @override
  Future<bool> checkIfHasLamp() async {
    return await lampInterface.hasLamp();
  }

  @override
  LampState setLampState({@required LampState newLampState}) {
    if (newLampState == LampState.on) {
      lampInterface.lightOn();
      return LampState.on;
    } else {
      lampInterface.lightOff();
      return LampState.off;
    }
  }

  @override
  LampState invertLampState({@required LampState currentLampState}) {
    final invertedLampState =
        currentLampState == LampState.on ? LampState.off : LampState.on;
    if (invertedLampState == LampState.on) {
      lampInterface.lightOn();
      return LampState.on;
    } else {
      lampInterface.lightOff();
      return LampState.off;
    }
  }

  @override
  Mc instantiateMcEntity({String word, List<String> morsecode}) {
    Mc entity;
    if (word != null) {
      entity = Mc.fromLetters(word);
    }
    if (morsecode != null) {
      entity = Mc.fromMorsecode(morsecode);
    }
    return entity;
  }

  @override
  Stream<LampState> playLampStream({@required Stream<bool> lampStream}) {
    var lampController = StreamController<LampState>();

    lampStream.listen((event) {
      var newLampState = LampState.off;
      if (event) newLampState = LampState.on;
      final LampState updatedLampState =
          setLampState(newLampState: newLampState);
      lampController.add(updatedLampState);
    }).onDone(() {
      lampController.close();
    });
    return lampController.stream;
  }
}


// TODO find a way to pause and cancel the stream
// TODO syncronize the light with the dislay