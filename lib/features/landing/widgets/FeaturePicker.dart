import 'package:flutter/material.dart';
import 'package:morsecode/features/landing/feature_interface.dart';

class FeaturePicker extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final Features metaLabel;
  const FeaturePicker({
    @required this.index,
    @required this.title,
    @required this.subtitle,
    @required this.metaLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Center(
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
