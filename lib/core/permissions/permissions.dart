import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

final List<PermissionInfo> permissionsInfo = [
  PermissionInfo(label: 'storage', instance: Permission.storage),
  PermissionInfo(label: 'camera', instance: Permission.camera),
];

class PermissionInfo {
  final String label;
  final Permission instance;
  PermissionInfo({
    @required this.label,
    @required this.instance,
  });

  Future<PermissionStatus> get status async => instance.status;
}
