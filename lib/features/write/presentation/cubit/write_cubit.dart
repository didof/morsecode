import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/write/domain/entitities/level.dart';
import 'package:morsecode/features/write/domain/levels.dart';

part 'write_state.dart';

class WriteCubit extends Cubit<WriteState> {
  WriteCubit() : super(WriteSetup(message: 'setup'));

  void setup({@required int levelIndex}) async {
    final Level level = levels[levelIndex];
    final Mc instance = level.words[0];
    emit(WriteActive(instance: instance));
  }
}
