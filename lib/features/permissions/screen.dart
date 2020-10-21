import 'package:flutter/material.dart';
import 'package:morsecode/core/permissions/permissions.dart';

class PermissionsScreen extends StatelessWidget {
  final List<PermissionInfo> permissionsInfo;
  final bool ready;
  PermissionsScreen(this.permissionsInfo, {this.ready = false});

  @override
  Widget build(BuildContext context) {
    print(permissionsInfo);
    print(ready);
    return Container();
  }
}
