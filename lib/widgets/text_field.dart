import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListTile(
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: theme.primaryColor,
            ),
          ),
          filled: true,
          fillColor: theme.primaryColorLight,
        ),
        maxLength: 5,
        cursorColor: theme.primaryColor,
        autofocus: true,
        keyboardType: TextInputType.name,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        color: theme.errorColor,
        alignment: Alignment.center,
        splashColor: theme.accentColor,
        iconSize: 32.0,
        onPressed: () {
          controller.clear();
        },
      ),
    );
  }
}
