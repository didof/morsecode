import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UseInvertLampState
    extends UseCaseNotFallibleSync<LampState, InvertLampStateParams> {
  final ConverterRepositoryContract repository;
  UseInvertLampState({@required this.repository});

  @override
  LampState call(InvertLampStateParams params) {
    return repository.invertLampState(
      currentLampState: params.currentLampState,
    );
  }
}
