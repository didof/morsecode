import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morsecode/core/UI/transitions/authentication_section.dart';
import 'package:morsecode/features/authentication/presentation/screen.dart';
import 'package:morsecode/features/converter/presentation/screen.dart';
import 'package:morsecode/core/globals/permissions.dart' as permissions;
import 'package:morsecode/core/injector_container.dart' as injector;

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
      title: 'morsecode',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: LandScreen(),
    );
  }
}

class LandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        FlatButton.icon(
          icon: const Icon(Icons.lightbulb_outline),
          label: const Text('Converter'),
          onPressed: () {
            Navigator.of(context).push(transitionFrom(
              Direction.right,
              landingPage: ConverterScreen(),
            ));
          },
        ),
      ]),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (waiting(snapshot.connectionState)) return FirebaseAuthWaiting();
        if (active(snapshot.connectionState))
          return FirebaseAuthActive(snapshot.hasData);
        return FirebaseAuthError();
      },
    );
  }
}

bool active(ConnectionState connectionState) {
  return connectionState == ConnectionState.active;
}

bool waiting(ConnectionState connectionState) {
  return connectionState == ConnectionState.waiting;
}

class FirebaseAuthWaiting extends StatelessWidget {
  final String message;
  FirebaseAuthWaiting({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          LinearProgressIndicator(),
          if (message != null) Expanded(child: Text(message)),
        ],
      )),
    );
  }
}

class FirebaseAuthActive extends StatelessWidget {
  final bool hasData;
  FirebaseAuthActive(this.hasData);

  @override
  Widget build(BuildContext context) {
    if (hasData)
      return Scaffold(
        body: Center(
          child: Text('has data'),
        ),
      );
    else
      return AuthenticationScreen();
  }
}

class FirebaseAuthError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('you need to restart the app'),
      ),
    );
  }
}
