import 'package:flutter/material.dart';
import 'package:morsecode/features/converter/presentation/screen.dart';
import 'package:morsecode/features/landing/feature_interface.dart';
import 'package:morsecode/features/landing/widgets/FeaturePicker.dart';
import 'package:morsecode/features/learn/screen.dart';
import 'package:morsecode/features/listen/screen.dart';
import 'package:morsecode/features/write/presentation/screen.dart';

final Map<Features, FeatureInterface> allFeatures = {
  Features.learn: FeatureInterface(
    title: 'Learn',
    subtitle: 'get to know how to morsecode work',
    icon: Icons.looks_one,
    instance: LearnScreen(),
  ),
  Features.write: FeatureInterface(
    title: 'Write',
    subtitle: 'practice your skill in encoding words in morsecode',
    icon: Icons.looks_two,
    instance: WriteScreen(),
  ),
  Features.listen: FeatureInterface(
    title: 'Listen',
    subtitle: 'practice your skill in decoding morsecode to words',
    icon: Icons.looks_3,
    instance: ListenScreen(),
  ),
  Features.converter: FeatureInterface(
    title: 'Converter',
    subtitle: 'transform any word into sound and light morsecode-timed',
    icon: Icons.looks_4,
    instance: ConverterScreen(),
  ),
};

List<FeaturePicker> generateFeaturePicker({
  @required List<Features> wantedFeatures,
}) {
  final List<FeaturePicker> list = [];
  for (var i = 0; i < wantedFeatures.length; i++) {
    final Features metaLabel = wantedFeatures[i];
    final FeatureInterface interface = allFeatures[metaLabel];
    list.add(FeaturePicker(
      index: i,
      metaLabel: metaLabel,
      title: interface.title,
      subtitle: interface.subtitle,
    ));
  }
  return list;
}
