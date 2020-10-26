import 'package:morsecode/features/landing/feature_interface.dart';
import 'package:permission_handler/permission_handler.dart';

const PERMISSIONS_NEEDED_AT_RUNAPP = const [Permission.storage];

/// the order of the pickers is decided in this list
const ACTIVE_FEATURES = const [
  Features.learn,
  Features.write,
  Features.listen,
  Features.converter,
];

const FEATURES_WHEEL_ANIMATIONS_DURATION = const Duration(milliseconds: 500);
