import 'package:flutter/material.dart';
import 'package:morsecode/core/globals/use_cases_contract.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class UseHasLamp extends UseCaseNotFallibleAsync<bool, NoParams> {
  final ConverterRepositoryContract repository;
  UseHasLamp({@required this.repository});

  @override
  Future<bool> call(NoParams params) async {
    return await repository.checkIfHasLamp();
  }
}
