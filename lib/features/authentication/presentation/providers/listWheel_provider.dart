import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWheelProvider with ChangeNotifier {
  ThemeData theme;
  int index = 0;
  final Duration duration;
  ListWheelProvider._({this.duration});

  factory ListWheelProvider({Duration duration}) {
    if (duration != null)
      return ListWheelProvider._(duration: duration);
    else
      return ListWheelProvider._(duration: Duration(milliseconds: 500));
  }

  void setTheme(ThemeData input) {
    theme = input;
  }

  void setIndex(int input) {
    index = input;
    notifyListeners();
  }

  double getOpacity(int input) {
    double computeDistance(int distance) =>
        (distance == 1 || distance == -1) ? 0.6 : 0.2;

    if (input == index) return 1.0;
    return computeDistance(index - input);
  }

  TextStyle getTitleTextStyle(int input) {
    if (input == index)
      return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        color: theme.accentColor,
      );
    else
      return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
        color: theme.primaryColor,
      );
  }

  TextStyle getSubtitleTextStyle(int input) {
    return TextStyle(color: input == index ? Colors.white : Colors.black);
  }

  LinearGradient getLinearGradient(
    int input, {
    bool inverted = false,
  }) {
    LinearGradient linearGradient(bool invert) {
      final color = invert ? Colors.white : theme.primaryColor;
      return LinearGradient(
        colors: [
          color,
          color.withOpacity(0.3),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.9, 1],
      );
    }

    if (input == index)
      return linearGradient(inverted);
    else
      return linearGradient(!inverted);
  }

  Color getColor(int input, {bool inverted = false}) {
    final color = Colors.white;
    if (input == index) {
      if (inverted)
        return theme.accentColor;
      else
        return color;
    } else {
      if (inverted)
        return theme.primaryColor;
      else
        return color;
    }
  }

  LinearGradient getBackground() {
    return LinearGradient(
      colors: [theme.primaryColor.withOpacity(0.3), Colors.white],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [0.1, 1],
    );
  }
}

typedef ProviderBuilder = Widget Function(
  BuildContext context,
  ListWheelProvider provider,
  ThemeData theme,
  BoxConstraints constraints,
);

class ListWheelProviderWidget extends StatelessWidget {
  final ProviderBuilder builder;
  final bool listen;
  final Duration duration;
  ListWheelProviderWidget({
    @required this.builder,
    this.listen = true,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider.value(
          value: ListWheelProvider(duration: duration),
          builder: (context, child) {
            final provider =
                Provider.of<ListWheelProvider>(context, listen: listen);
            provider.setTheme(theme);
            return builder(context, provider, theme, constraints);
          },
        );
      },
    );
  }
}

class ListWheelProviderConsumerWidget extends StatelessWidget {
  final ProviderBuilder builder;
  ListWheelProviderConsumerWidget({@required this.builder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListWheelProvider>(context);
    final ThemeData theme = provider.theme;
    return LayoutBuilder(builder: (context, constraints) {
      return builder(context, provider, theme, constraints);
    });
  }
}
