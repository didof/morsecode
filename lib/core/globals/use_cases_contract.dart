import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:morsecode/core/entities/failure.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

abstract class UseCaseFallibleAsync<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseNotFallibleAsync<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseFallibleSync<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class UseCaseNotFallibleSync<Type, Params> {
  Type call(Params params);
}

abstract class Params {}

class NoParams extends Params {}

class SetLampStateParams extends Params {
  final LampState newLampState;
  SetLampStateParams({@required this.newLampState});
}

class InvertLampStateParams extends Params {
  final LampState currentLampState;
  InvertLampStateParams({@required this.currentLampState});
}

class InstantiateMcFromWordParams extends Params {
  final String word;
  InstantiateMcFromWordParams({@required this.word});
}

class PlayLampStream extends Params {
  final Stream<bool> stream;
  PlayLampStream({@required this.stream});
}

class PauseLampStream extends Params {
  final Stream<bool> stream;
  PauseLampStream({@required this.stream});
}
