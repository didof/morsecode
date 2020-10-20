import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      primarySwatch: Colors.blue,
      accentColor: Colors.amber,
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FirebaseAuthWaiting();
        } else if (snapshot.connectionState == ConnectionState.active) {
          return FirebaseAuthActive(snapshot.hasData);
        }
        return FirebaseAuthDone();
      },
    );
  }
}

class FirebaseAuthWaiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
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

class FirebaseAuthDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('you need to restart the app'),
      ),
    );
  }
}
