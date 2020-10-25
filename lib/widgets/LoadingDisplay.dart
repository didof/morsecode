import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  final String message;
  const LoadingDisplay({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(child: CircularProgressIndicator()),
        if (message != null) Text(message),
      ],
    );
  }
}
