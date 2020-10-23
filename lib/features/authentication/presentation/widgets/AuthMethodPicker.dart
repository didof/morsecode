import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morsecode/features/authentication/presentation/providers/listWheel_provider.dart';

class AuthMethodPicker extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  AuthMethodPicker({
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelProviderConsumerWidget(
      builder: (context, provider, theme, constraints) {
        return AnimatedOpacity(
          duration: provider.duration,
          opacity: provider.getOpacity(index),
          child: AnimatedContainer(
            duration: provider.duration,
            width: constraints.maxWidth / 10 * 8,
            height: constraints.maxHeight / 10 * 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: provider.getLinearGradient(index),
            ),
            child: Center(
              child: ListTile(
                leading: AnimatedContainer(
                  duration: provider.duration,
                  decoration: BoxDecoration(
                    color: provider.getColor(index),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16.0),
                  child: FaIcon(
                    icon,
                    color: provider.getColor(index, inverted: true),
                  ),
                ),
                title: AnimatedDefaultTextStyle(
                  child: Text(title),
                  duration: provider.duration,
                  curve: Curves.easeInOut,
                  style: provider.getTitleTextStyle(index),
                ),
                subtitle:
                    Text(subtitle, style: provider.getSubtitleTextStyle(index)),
              ),
            ),
          ),
        );
      },
    );
  }
}
