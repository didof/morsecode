import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/domain/authMethods.dart';
import 'package:morsecode/features/authentication/presentation/sections/notYetImplemented.dart';
import 'package:morsecode/features/authentication/presentation/sections/signInSection.dart';
import 'package:morsecode/features/authentication/presentation/sections/signUpSection.dart';

class AuthenticationRedirector extends StatelessWidget {
  final Methods method;
  AuthenticationRedirector(this.method);

  @override
  Widget build(BuildContext context) {
    switch (method) {
      case Methods.SignUpEmailAndPassword:
        return SignUpSection();
      case Methods.SignInEmailAndPassword:
        return SignInSection();
      default:
        return NotYetImplemented();
    }
  }
}
