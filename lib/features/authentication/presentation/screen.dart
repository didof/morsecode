import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/domain/authMethods.dart';
import 'package:morsecode/core/UI/transitions/authentication_section.dart';
import 'package:morsecode/features/authentication/presentation/providers/listWheel_provider.dart';
import 'package:morsecode/features/authentication/presentation/widgets/AuthMethodPicker.dart';
import 'package:morsecode/widgets/ListWheelGestureDetector.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListWheelProviderWidget(
      builder: (context, provider, theme, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  gradient: provider.getBackground(),
                )),
                ListWheelGestureDetector(
                  children: _generateIndexedAuthMethodsPickers(authMethods),
                  itemExtent: constraints.maxHeight / 4,
                  onSelectedItemChanged: (value) => provider.setIndex(value),
                  onItemTap: () {
                    final AuthMethod authMethod = authMethods[provider.index];
                    Navigator.of(context).push(transitionFrom(
                      Direction.bottom,
                      landingPage: authMethod.instance,
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

List<AuthMethodPicker> _generateIndexedAuthMethodsPickers(
  List<AuthMethod> list,
) {
  final List<AuthMethodPicker> output = [];
  for (var i = 0; i < list.length; i++) {
    output.add(AuthMethodPicker(
      icon: list[i].icon,
      title: list[i].title,
      subtitle: list[i].subtitle,
      index: i,
    ));
  }
  return output;
}
