import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:morsecode/core/permissions/check.dart';
import 'package:morsecode/features/authentication/presentation/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      title: 'morsecode',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Home(),
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
