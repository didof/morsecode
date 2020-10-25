part of 'converter_cubit.dart';

@immutable
abstract class ConverterState {
  const ConverterState();
}

class ConverterSetup extends ConverterState {
  final String message;
  ConverterSetup({@required this.message});
}

class ConverterWithLamp extends ConverterState {
  final LampState lampState;
  ConverterWithLamp({@required this.lampState});
}

class ConverterWithoutLamp extends ConverterState {}

class ConverterMorsecoding extends ConverterState {
  final String word;
  final bool done;
  final LampState lampState;
  final Stream<bool> stream;
  const ConverterMorsecoding({
    @required this.word,
    this.done = false,
    @required this.lampState,
    @required this.stream,
  });
}

class ConverterWithStream extends ConverterState {
  final String word;
  final Stream<bool> stream;
  ConverterWithStream({@required this.word, @required this.stream});
}

class ConverterLoading extends ConverterState {
  final String message;
  ConverterLoading({this.message});
}

class ConverterError extends ConverterState {}
