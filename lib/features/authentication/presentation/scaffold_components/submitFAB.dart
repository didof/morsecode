import 'package:flutter/material.dart';

class SubmitFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: null,
      child: const Text('go'),
      heroTag: 'authentication_title',
    );
  }
}
