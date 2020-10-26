import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morsecode/core/UI/transitions/authentication_section.dart';
import 'package:morsecode/features/authentication/presentation/screen.dart';
import 'package:morsecode/features/converter/presentation/screen.dart';
import 'package:morsecode/core/globals/permissions.dart' as permissions;
import 'package:morsecode/core/injector_container.dart' as injector;
import 'package:morsecode/features/landing/screen.dart';
import 'package:morsecode/widgets/ListWheelGestureDetector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await permissions.init();
  await injector.serviceLocatorInject();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      title: 'Morsecode',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: LandScreen(),
    );
  }
}
