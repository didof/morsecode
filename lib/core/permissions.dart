import 'package:morsecode/core/dev_facade.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> init() async {
  final notGranted = await _getNotGranted(PERMISSIONS_NEEDED_AT_RUNAPP);
  await _askPermissions(notGranted);
}

Future<List<Permission>> _getNotGranted(List<Permission> permissions) async {
  List<Permission> notGranted = [];
  return await Future.wait(permissions.map((p) async {
    return await p.status;
  })).then((statuses) {
    for (var i = 0; i < permissions.length; i++) {
      if (statuses[i] == PermissionStatus.granted) {
        print('${permissions[i]} is already granted');
      } else {
        print('${permissions[i]} is not granted');
        notGranted.add(permissions[i]);
      }
    }
    return notGranted;
  });
}

Future<Map<Permission, PermissionStatus>> _askPermissions(
  List<Permission> permissions,
) async {
  // in order to allow the asking for permission, the manifest must present the
  // relative <uses-permission android:name="android.permission.[NATIVE_FEATURE]" />
  return await permissions.request();
}
