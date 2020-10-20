import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/presentation/widgets/AuthCard.dart';

class NotYetImplemented extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(
        title: 'Not yet Implemented',
        child: Center(
          child: FlatButton.icon(
            icon: const Icon(Icons.chevron_left),
            label: const Text('Go back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
