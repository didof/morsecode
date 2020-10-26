import 'package:flutter/material.dart';

enum Features {
  // Authentication,
  // Permissions,
  // Theming,
  learn,
  write,
  listen,
  converter,
  pushNotification,
}

class FeatureInterface {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget instance;
  const FeatureInterface({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.instance,
  });
}
