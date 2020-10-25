import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UsePlayLampStream
    extends UseCaseNotFallibleSync<Stream<LampState>, PlayLampStream> {
  final ConverterRepositoryContract repository;
  UsePlayLampStream({@required this.repository});

  @override
  Stream<LampState> call(PlayLampStream params) {
    return repository.playLampStream(lampStream: params.stream);
  }
}
