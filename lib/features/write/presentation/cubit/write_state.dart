part of 'write_cubit.dart';

@immutable
abstract class WriteState {
  const WriteState();
}

class WriteSetup extends WriteState {
  final String message;
  const WriteSetup({@required this.message});
}

class WriteActive extends WriteState {
  final Mc instance;
  const WriteActive({@required this.instance});
}
