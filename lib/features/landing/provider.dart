import 'package:flutter/material.dart';
import 'package:morsecode/core/UI/transitions/authentication_section.dart';
import 'package:morsecode/features/landing/feature_interface.dart';
import 'package:morsecode/features/landing/feature_list.dart';
import 'package:morsecode/features/landing/widgets/FeaturePicker.dart';
import 'package:provider/provider.dart';

class LandingProvider with ChangeNotifier {
  int _index;
  ThemeData _theme;

  LandingProvider._(
    int index,
    ThemeData theme,
  )   : _index = index,
        _theme = theme;

  factory LandingProvider({int initialIndex = 0, @required ThemeData theme}) {
    return LandingProvider._(initialIndex, theme);
  }

  int get i => _index;
  ThemeData get theme => _theme;

  void setIndex(int input) {
    _index = input;
    notifyListeners();
  }

  Direction getTransitionDirection() {
    if (_index == 0) return Direction.top;
    if (_index == 1) return Direction.right;
    if (_index == 2) return Direction.bottom;
    return Direction.left;
  }

  Widget getLandingPage(List<FeaturePicker> listAvaiableFeatures) {
    final Features metaLabel = listAvaiableFeatures[_index].metaLabel;
    return allFeatures[metaLabel].instance;
  }
}

typedef ProviderBuilder = Widget Function(
  BuildContext context,
  LandingProvider provider,
  ThemeData theme,
  BoxConstraints constraints,
);

class LandingProviderWidget extends StatelessWidget {
  final ProviderBuilder builder;
  final bool listen;
  const LandingProviderWidget({
    @required this.builder,
    this.listen = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider.value(
          value: LandingProvider(initialIndex: 0, theme: theme),
          builder: (context, child) {
            final provider =
                Provider.of<LandingProvider>(context, listen: listen);
            return builder(context, provider, theme, constraints);
          },
        );
      },
    );
  }
}
