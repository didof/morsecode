import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UsePauseLampStream
    extends UseCaseNotFallibleSync<Stream<LampState>, PauseLampStream> {
  final ConverterRepositoryContract repository;
  UsePauseLampStream({@required this.repository});

  @override
  Stream<LampState> call(PauseLampStream params) {
    return repository.pauseLampStream(lampStream: params.stream);
  }
}
