import 'package:flutter/material.dart';
import 'package:morsecode/core/UI/transitions/authentication_section.dart';
import 'package:morsecode/core/dev_facade.dart';
import 'package:morsecode/features/landing/feature_list.dart';
import 'package:morsecode/features/landing/provider.dart';
import 'package:morsecode/widgets/ListWheelGestureDetector.dart';

class LandScreen extends StatelessWidget {
  final AppBar appBar = AppBar(
    title: const Text('Morsecode'),
    centerTitle: true,
    elevation: 0,
  );

  @override
  Widget build(BuildContext context) {
    final pickersList = generateFeaturePicker(wantedFeatures: ACTIVE_FEATURES);

    return LandingProviderWidget(
      builder: (context, provider, theme, constraints) {
        return Scaffold(
          appBar: appBar,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [theme.primaryColor, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                ListWheelGestureDetector(
                  itemExtent: constraints.maxHeight / 4,
                  children: pickersList,
                  onSelectedItemChanged: (index) => provider.setIndex(index),
                  onItemTap: () {
                    Navigator.of(context).push(transitionFrom(
                      provider.getTransitionDirection(),
                      landingPage: provider.getLandingPage(pickersList),
                    ));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// TODO add animations
