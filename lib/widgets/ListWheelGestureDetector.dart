import 'package:flutter/material.dart';

enum TapLocation {
  top,
  bottom,
}

class ListWheelGestureDetector extends StatefulWidget {
  final List<Widget> children;
  final double itemExtent;
  final double itemWidth;

  final Function(int index) onSelectedItemChanged;
  final Function onItemTap;

  ListWheelGestureDetector({
    @required this.itemExtent,
    this.children,
    this.itemWidth,
    this.onSelectedItemChanged,
    this.onItemTap,
  }) : assert(itemExtent != null);

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
            physics: FixedExtentScrollPhysics(),
          ),
        ),
        Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: RollWheelGestureDetector(
                controller: _controller,
                itemExtent: widget.itemExtent,
                isTop: true,
              ),
            ),
            Container(
              height: widget.itemExtent,
              width:
                  widget.itemWidth != null ? widget.itemWidth : double.infinity,
              child: GestureDetector(onTap: widget.onItemTap),
            ),
            Expanded(
              child: RollWheelGestureDetector(
                controller: _controller,
                itemExtent: widget.itemExtent,
                isTop: false,
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class RollWheelGestureDetector extends StatelessWidget {
  final double itemExtent;
  final ScrollController controller;
  final Function onTap;
  final Function onLongPress;
  const RollWheelGestureDetector._({
    this.itemExtent,
    this.controller,
    this.onTap,
    this.onLongPress,
  })  : assert(itemExtent != null),
        assert(controller != null);

  factory RollWheelGestureDetector({
    @required double itemExtent,
    @required ScrollController controller,
    @required bool isTop,
  }) {
    assert(isTop != null);
    void animate(double location) async {
      return controller.animateTo(
        location,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void tapPositionAt(TapLocation tapLocation) {
      final double offset = controller.offset;
      double newLocation;
      if (tapLocation == TapLocation.top) {
        if (offset == controller.position.minScrollExtent) return;
        newLocation = offset - itemExtent;
      } else {
        if (offset == controller.position.maxScrollExtent) return;
        newLocation = offset + itemExtent;
      }
      animate(newLocation);
    }

    void longPressPositionAt(TapLocation tapLocation) {
      double newLocation;
      if (tapLocation == TapLocation.top) {
        newLocation = controller.position.minScrollExtent;
      } else {
        newLocation = controller.position.maxScrollExtent;
      }
      animate(newLocation);
    }

    return RollWheelGestureDetector._(
      controller: controller,
      itemExtent: itemExtent,
      onTap: () => tapPositionAt(isTop ? TapLocation.top : TapLocation.bottom),
      onLongPress: () =>
          longPressPositionAt(isTop ? TapLocation.top : TapLocation.bottom),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
