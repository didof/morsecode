import 'dart:async';
import 'package:meta/meta.dart';

Stream<bool> asyncronizeMorsecodeToBool({
  @required List<String> morsecode,
}) async* {
  print('[asyncronizeMorsecodeToBool] called with morsecode:$morsecode');
  final stringified = morsecode.join(" ");

  for (var i = 0; i < stringified.length; i++) {
    yield true;
    await Future.delayed(Duration(milliseconds: durations[stringified[i]]));
    yield false;
  }
}

const durations = const {
  '.': 500,
  '-': 1000,
  ' ': 2000,
};