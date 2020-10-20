import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final String title;
  final Widget child;
  AuthCard({
    @required this.title,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            width: constraints.maxWidth / 10 * 8,
            height: constraints.maxHeight / 10 * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 28),
                  ),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
