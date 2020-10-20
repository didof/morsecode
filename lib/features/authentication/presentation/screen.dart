import 'package:flutter/material.dart';
import 'package:morsecode/core/authentication/authMethods.dart';
import 'package:morsecode/features/authentication/presentation/providers/listWheel_provider.dart';
import 'package:morsecode/features/authentication/presentation/scaffold_components/pickerSelectorFAB.dart';
import 'package:morsecode/features/authentication/presentation/widgets/AuthMethodPicker.dart';

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
                ListWheelScrollView(
                  itemExtent: constraints.maxHeight / 4,
                  onSelectedItemChanged: (value) => provider.setIndex(value),
                  children: _generateIndexedAuthMethodsPickers(authMethods),
                ),
              ],
            ),
          ),
          floatingActionButton:
              PickerSelectorFAB(theme, authMethod: authMethods[provider.index]),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
