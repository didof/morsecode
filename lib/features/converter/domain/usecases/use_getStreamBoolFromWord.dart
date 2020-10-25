import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UseInstantiateMcFromWord
    extends UseCaseNotFallibleSync<Mc, InstantiateMcFromWordParams> {
  final ConverterRepositoryContract repository;
  UseInstantiateMcFromWord({@required this.repository});

  @override
  Mc call(InstantiateMcFromWordParams params) {
    return repository.instantiateMcEntity(word: params.word);
  }
}
