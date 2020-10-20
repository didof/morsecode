import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/presentation/providers/form_provider.dart';

class SubmitFAB extends StatefulWidget {
  @override
  _SubmitFABState createState() => _SubmitFABState();
}

class _SubmitFABState extends State<SubmitFAB>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isAnimating;

  @override
  void initState() {
    super.initState();
    _isAnimating = false;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormProviderAccess(
      builder: (context, provider) {
        final ThemeData theme = Theme.of(context);
        return FloatingActionButton(
          child: AnimatedIcon(
            icon: AnimatedIcons.add_event,
            progress: _animationController,
            color: theme.primaryColor,
            size: 32,
          ),
          heroTag: 'authentication_title',
          onPressed: () {
            setState(() {
              _isAnimating = !_isAnimating;
              _isAnimating
                  ? _animationController.forward()
                  : _animationController.reverse();
            });
            provider.saveValues();
          },
        );
      },
    );
  }
}
