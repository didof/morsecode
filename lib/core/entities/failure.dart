import 'package:meta/meta.dart';

abstract class Failure {
  final String code;
  final String message;
  Failure({
    @required this.code,
    @required this.message,
  });
}