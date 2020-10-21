import 'package:flutter/material.dart';
import 'package:morsecode/core/authentication/authMethods.dart';
import 'package:morsecode/core/transitions/authentication_section.dart';

class PickerSelectorFAB extends StatelessWidget {
  final AuthMethod authMethod;
  final ThemeData theme;
  PickerSelectorFAB(
    this.theme, {
    @required this.authMethod,
  });

  @override
  Widget build(BuildContext context) {
    final color = theme.primaryColor;
    return FloatingActionButton.extended(
      label: Text(authMethod.title, style: TextStyle(color: color)),
      icon: Icon(authMethod.icon, color: color),
      heroTag: 'authentication_title',
      splashColor: theme.primaryColor,
      onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return authMethod.instance;
        // }));
        Navigator.of(context)
            .push(transitionsAuthentication(authMethod.instance));
      },
    );
  }
}
