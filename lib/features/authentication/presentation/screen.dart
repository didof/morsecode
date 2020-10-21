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
                // ListWheelScrollView(
                //   itemExtent: constraints.maxHeight / 4,
                //   onSelectedItemChanged: (value) => provider.setIndex(value),
                //   children: _generateIndexedAuthMethodsPickers(authMethods),
                // ),
                ListWheelGestureDetector(
                  itemExtent: constraints.maxHeight / 4,
                  onSelectedItemChanged: (value) => provider.setIndex(value),
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

enum ScrollModalities {
  onTap,
  onDrag,
}

enum TapLocation {
  top,
  middle,
  bottom,
}

class ListWheelGestureDetector extends StatefulWidget {
  final double itemExtent;
  final double itemWidth;
  final Function(int index) onSelectedItemChanged;
  final List<ScrollModalities> scrollModalities;
  ListWheelGestureDetector({
    @required this.itemExtent,
    this.itemWidth,
    this.onSelectedItemChanged,
    this.scrollModalities = const [
      ScrollModalities.onDrag,
      ScrollModalities.onTap
    ],
  });

  @override
  _ListWheelGestureDetectorState createState() =>
      _ListWheelGestureDetectorState();
}

class _ListWheelGestureDetectorState extends State<ListWheelGestureDetector> {
  int _lastReportedItemIndex = 0;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool get onTapAbilited =>
      widget.scrollModalities.contains(ScrollModalities.onTap);

  void tapPosition(TapLocation tapLocation) {
    double newLocation;
    switch (tapLocation) {
      case TapLocation.top:
        newLocation = _controller.offset - widget.itemExtent;
        break;
      case TapLocation.bottom:
        newLocation = _controller.offset + widget.itemExtent;
        break;
      case TapLocation.middle:
      default:
        return print('do other stuff');
    }

    print('animating');
    _controller.animateTo(
      newLocation,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: widget.itemWidth,
          child: ListWheelScrollView(
            controller: _controller,
            itemExtent: widget.itemExtent,
            children: _generateIndexedAuthMethodsPickers(authMethods),
            onSelectedItemChanged: widget.onSelectedItemChanged,
          ),
        ),
        Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap:
                    onTapAbilited ? () => tapPosition(TapLocation.top) : null,
              ),
            ),
            Container(
              height: widget.itemExtent,
              width:
                  widget.itemWidth != null ? widget.itemWidth : double.infinity,
              child: GestureDetector(
                onTap: onTapAbilited
                    ? () => tapPosition(TapLocation.middle)
                    : null,
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapAbilited
                    ? () => tapPosition(TapLocation.bottom)
                    : null,
              ),
            )
          ],
        )),
      ],
    );
  }
}
