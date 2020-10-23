import 'package:flutter/material.dart';

enum TapLocation {
  top,
  bottom,
}

class ListWheelGestureDetector extends StatefulWidget {
  final List<Widget> children;
  final double itemExtent;
  final double itemWidth;

  final bool specular;

  final ScrollModalities scrollModalities;
  final Function(int index) onSelectedItemChanged;
  final Function onItemTap;
  final Function onTopTap;
  final Function onBottomTap;
  final Function onSpecularTap;

  ListWheelGestureDetector({
    @required this.itemExtent,
    this.children,
    this.itemWidth,
    this.specular = true,
    this.onSelectedItemChanged,
    this.scrollModalities = const ScrollModalities(),
    this.onItemTap,
    this.onTopTap,
    this.onBottomTap,
    this.onSpecularTap,
  })  : assert(specular
            ? (onTopTap == null && onBottomTap == null)
            : onSpecularTap == null),
        assert(itemExtent != null);

  @override
  _ListWheelGestureDetectorState createState() =>
      _ListWheelGestureDetectorState();
}

class _ListWheelGestureDetectorState extends State<ListWheelGestureDetector> {
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

  bool get onTapAbilited => widget.scrollModalities.onTap;
  bool get onDoubleTapAbilited => widget.scrollModalities.onDoubleTap;
  bool get onDragAbilited => widget.scrollModalities.onDrag;

  _animate(double location) {
    return _controller.animateTo(
      location,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void tapPositionAt(TapLocation tapLocation) {
    final double offset = _controller.offset;
    double newLocation;
    if (tapLocation == TapLocation.top) {
      if (offset == _controller.position.minScrollExtent) return;
      newLocation = offset - widget.itemExtent;
    } else {
      if (offset == _controller.position.maxScrollExtent) return;
      newLocation = offset + widget.itemExtent;
    }

    _animate(newLocation);
  }

  void longPressPositionAt(TapLocation tapLocation) {
    double newLocation;
    if (tapLocation == TapLocation.top) {
      newLocation = _controller.position.minScrollExtent;
    } else {
      newLocation = _controller.position.maxScrollExtent;
    }

    _animate(newLocation);
  }

  Widget _generateGestureDetector(TapLocation tapLocation) {
    Function _generateOnTap() {
      if (onTapAbilited) {
        print('on tap is abilited');
        if (tapLocation == TapLocation.top)
          return widget.onTopTap ?? () => tapPositionAt(tapLocation);
        if (tapLocation == TapLocation.bottom)
          return widget.onBottomTap ?? () => tapPositionAt(tapLocation);
      }
      return null;
    }

    return GestureDetector(
      onTap: _generateOnTap(),
      onLongPress: onDoubleTapAbilited
          ? () => longPressPositionAt(TapLocation.top)
          : null,
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
            children: widget.children,
            onSelectedItemChanged: widget.onSelectedItemChanged,
          ),
        ),
        Container(
            child: Column(
          children: <Widget>[
            Expanded(child: _generateGestureDetector(TapLocation.top)),
            Container(
              height: widget.itemExtent,
              width:
                  widget.itemWidth != null ? widget.itemWidth : double.infinity,
              child: GestureDetector(
                onTap: widget.onItemTap,
                onLongPress: () {
                  print('long jon');
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTapAbilited
                    ? () => tapPositionAt(TapLocation.bottom)
                    : null,
                onLongPress: onDoubleTapAbilited
                    ? () => longPressPositionAt(TapLocation.bottom)
                    : null,
              ),
            )
          ],
        )),
      ],
    );
  }
}

class ScrollModalities {
  final bool onTap;
  final bool onDoubleTap;
  final bool onDrag;
  const ScrollModalities({
    this.onTap = true,
    this.onDoubleTap = true,
    this.onDrag = true,
  });
}
