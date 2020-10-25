import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morsecode/features/authentication/presentation/sections/authenticationRedirector.dart';

enum Methods {
  SignUpEmailAndPassword,
  SignInEmailAndPassword,
  NotYetImplemented,
}

final List<AuthMethod> authMethods = [
  AuthMethod(
    icon: FontAwesomeIcons.userPlus,
    title: 'Signup',
    subtitle: 'Create a new account using your e-mail and setting a password',
    instance: AuthenticationRedirector(Methods.SignUpEmailAndPassword),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.signInAlt,
    title: 'Signin',
    subtitle: 'Authenticate using e-mail and password',
    instance: AuthenticationRedirector(Methods.SignInEmailAndPassword),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.phone,
    title: 'Phone',
    subtitle: 'Authenticate using telephone',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.google,
    title: 'Google',
    subtitle: 'Authenticate using Google',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.facebook,
    title: 'Facebook',
    subtitle: 'Authenticate using Facebook',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.github,
    title: 'GitHub',
    subtitle: 'Authenticate using GitHub',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.yahoo,
    title: 'Yahoo',
    subtitle: 'Authenticate using Yahoo',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.microsoft,
    title: 'Microsoft',
    subtitle: 'Authenticate using Microsoft',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.apple,
    title: 'Apple',
    subtitle: 'Authenticate using Apple',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
  AuthMethod(
    icon: FontAwesomeIcons.userSecret,
    title: 'Anonymus',
    subtitle: 'Authenticate using Anonymus',
    instance: AuthenticationRedirector(Methods.NotYetImplemented),
  ),
];

class AuthMethod {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget instance;
  AuthMethod({
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.instance,
  });
}
