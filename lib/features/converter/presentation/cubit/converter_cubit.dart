import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';
import 'package:morsecode/features/converter/domain/usecases/use_hasLamp.dart';
import 'package:morsecode/features/converter/domain/usecases/use_invertLampState.dart';
import 'package:morsecode/features/converter/domain/usecases/use_playLampStream.dart';
import 'package:morsecode/features/converter/domain/usecases/use_setLampState.dart';
import 'package:morsecode/features/converter/domain/usecases/use_getStreamBoolFromWord.dart';
import 'package:morsecode/features/converter/presentation/stages/with_lamp.dart';
part 'converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final UseHasLamp useHasLamp;
  final UseSetLampState useSetLampState;
  final UseInvertLampState useInvertLampState;
  final UseInstantiateMcFromWord useInstantiateMcFromWord;
  final UsePlayLampStream usePlayLampStream;

  ConverterCubit({
    @required this.useHasLamp,
    @required this.useSetLampState,
    @required this.useInvertLampState,
    @required this.useInstantiateMcFromWord,
    @required this.usePlayLampStream,
  }) : super(ConverterSetup(message: 'setup'));

  // ! private methods
  Mc _getInstanceFromWord(String word) {
    return useInstantiateMcFromWord(InstantiateMcFromWordParams(word: word));
  }

  // ! callable methods
  Future<void> setup() async {
    print('[setup] init');
    final bool hasLamp = await useHasLamp(NoParams());
    print('[setup] hasLamp:$hasLamp');
    if (hasLamp) {
      final LampState updatedLampState =
          useSetLampState(SetLampStateParams(newLampState: LampState.off));
      print('[setup] updatedLampState:$updatedLampState');
      emit(ConverterWithLamp(lampState: updatedLampState));
    } else {
      emit(ConverterWithoutLamp());
    }
  }

  void setLampState({@required LampState newLampState}) {
    final LampState updatedLampState = useSetLampState(
      SetLampStateParams(newLampState: newLampState),
    );
    emit(ConverterWithLamp(lampState: updatedLampState));
  }

  void invertLampState({@required LampState currentLampState}) {
    print('[invertLampState] currentLampState:$currentLampState');
    final LampState updatedLampState = useInvertLampState(
      InvertLampStateParams(
        currentLampState: currentLampState,
      ),
    );
    print('[invertLampState] updatedLampState:$updatedLampState');
    emit(ConverterWithLamp(lampState: updatedLampState));
  }

  void getStreamBoolFromWord({
    @required String word,
    @required bool lamp,
    @required StreamSpeed streamSpeed,
  }) {
    print('[getStreamBoolFromWord] called with word:$word');
    final Mc instance = _getInstanceFromWord(word);
    final Stream<bool> streamBool = instance
        .streamMorsecodeToBool(streamSpeed: streamSpeed)
        .asBroadcastStream();
    emit(ConverterWithStream(
      word: word,
      stream: streamBool,
      lamp: lamp,
    ));
  }

  void playLampStream({@required Stream<bool> streamBool}) {
    print('[playLampStream] received streamBool:$streamBool');
    usePlayLampStream(PlayLampStream(stream: streamBool));
  }

  void pauseLampStream({@required Stream<bool> streamBool}) {
    print('[pauseLampStream] called with streamBool:$streamBool');
  }

  void resetToWithLampUI({@required Stream<bool> streamBool}) {
    print('[resetToWithLampUI] called with streamBool:$streamBool');
    streamBool.drain();
    print('[resetToWithLampUI] stream was drained');
    emit(ConverterWithLamp(lampState: LampState.off));
  }
}
