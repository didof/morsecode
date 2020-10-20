import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/presentation/providers/form_provider.dart';
import 'package:morsecode/features/authentication/presentation/scaffold_components/submitFAB.dart';
import 'package:morsecode/features/authentication/presentation/widgets/AuthCard.dart';

class SignUpSection extends StatelessWidget {
  final AppBar appBar = AppBar(
    title: const Text('Signup'),
  );

  @override
  Widget build(BuildContext context) {
    return FormProviderWidget(
      builder: (context, provider, theme, constraints) {
        return Scaffold(
          appBar: appBar,
          floatingActionButton: SubmitFAB(),
          // floatingActionButtonLocation: provider.getFABLocation(),
          body: Center(
            child: AuthCard(
              title: 'Signup',
              child: SignUpForm(reset: provider.reset),
            ),
          ),
        );
      },
    );
  }
}

class SignUpForm extends StatefulWidget {
  final Function reset;
  SignUpForm({@required this.reset});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _key = GlobalKey<FormState>();
  String email, password;

  @override
  void dispose() {
    widget.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormProviderWidgetConsumerWidget(
      formKey: _key,
      formBuilder: (context, provider, theme, constraints) {
        return Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'e-mail'),
              onSaved: (value) => provider.setValue(Fields.Email, value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              onSaved: (value) => provider.setValue(Fields.Password, value),
              obscureText: true,
            ),
          ],
        );
      },
    );
  }
}

// TODO
/// on the trigger event, send the user to the warden managed with cubit
/// the warden does all the checks (uid, cloud, saves in hive) and dispatch
/// the right screen
