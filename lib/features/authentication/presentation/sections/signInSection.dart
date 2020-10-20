import 'package:flutter/material.dart';
import 'package:morsecode/features/authentication/presentation/providers/form_provider.dart';
import 'package:morsecode/features/authentication/presentation/scaffold_components/submitFAB.dart';
import 'package:morsecode/features/authentication/presentation/widgets/AuthCard.dart';

class SignInSection extends StatelessWidget {
  final AppBar appBar = AppBar(
    title: const Text('Signin'),
  );

  @override
  Widget build(BuildContext context) {
    return FormProviderWidget(
      builder: (context, provider, theme, constraints) {
        return Scaffold(
          appBar: appBar,
          floatingActionButton: SubmitFAB(),
          body: Center(
            child: AuthCard(
              title: 'Signin',
              child: SignInForm(reset: provider.reset),
            ),
          ),
        );
      },
    );
  }
}

class SignInForm extends StatefulWidget {
  final Function reset;
  SignInForm({@required this.reset});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _key = GlobalKey<FormState>();

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
        print(provider.formKey);
        return Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'e-mail'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
            ),
          ],
        );
      },
    );
  }
}
