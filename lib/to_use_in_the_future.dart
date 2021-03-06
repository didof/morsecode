// // The following will be implemented in the future
// class HomeWithAuth extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
//         if (waiting(snapshot.connectionState)) return FirebaseAuthWaiting();
//         if (active(snapshot.connectionState))
//           return FirebaseAuthActive(snapshot.hasData);
//         return FirebaseAuthError();
//       },
//     );
//   }
// }

// bool active(ConnectionState connectionState) {
//   return connectionState == ConnectionState.active;
// }

// bool waiting(ConnectionState connectionState) {
//   return connectionState == ConnectionState.waiting;
// }

// class FirebaseAuthWaiting extends StatelessWidget {
//   final String message;
//   FirebaseAuthWaiting({this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         children: [
//           LinearProgressIndicator(),
//           if (message != null) Expanded(child: Text(message)),
//         ],
//       )),
//     );
//   }
// }

// class FirebaseAuthActive extends StatelessWidget {
//   final bool hasData;
//   FirebaseAuthActive(this.hasData);

//   @override
//   Widget build(BuildContext context) {
//     if (hasData)
//       return Scaffold(
//         body: Center(
//           child: Text('has data'),
//         ),
//       );
//     else
//       return AuthenticationScreen();
//   }
// }

// class FirebaseAuthError extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('you need to restart the app'),
//       ),
//     );
//   }
// }
