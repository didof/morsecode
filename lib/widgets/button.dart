import 'package:flutter/material.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';

class OnOffButton extends StatelessWidget {
  final LampState currentLampState;
  final Function dispatch;
  const OnOffButton({
    @required this.currentLampState,
    @required this.dispatch,
  });

  Widget get lampButtonText =>
      currentLampState == LampState.off ? const Text('ON') : const Text('OFF');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FlatButton(
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: theme.primaryColor),
      ),
      splashColor: theme.accentColor,
      padding: const EdgeInsets.all(16.0),
      textColor: Colors.white,
      child: lampButtonText,
      onPressed: dispatch,
    );
  }
}

class CustomButton extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final Function dispatch;
  const CustomButton({
    @required this.icon,
    @required this.label,
    @required this.dispatch,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FlatButton.icon(
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: theme.primaryColor),
      ),
      splashColor: theme.accentColor,
      padding: const EdgeInsets.all(16.0),
      textColor: Colors.white,
      icon: icon,
      label: label,
      onPressed: dispatch,
    );
  }
}
