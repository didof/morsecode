import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UseSetLampState
    extends UseCaseNotFallibleSync<LampState, SetLampStateParams> {
  final ConverterRepositoryContract repository;
  UseSetLampState({@required this.repository});

  @override
  LampState call(SetLampStateParams params) {
    return repository.setLampState(
      newLampState: params.newLampState,
    );
  }
}
