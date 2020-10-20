import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormProvider with ChangeNotifier {
  GlobalKey<FormState> formKey;

  ThemeData theme;
  String email;
  String password;

  FormProvider({
    this.email,
    this.password,
  });

  List<dynamic> get props => [email, password, theme, formKey];

  void setTheme(ThemeData input) {
    theme = input;
  }

  void setFormKey(GlobalKey<FormState> input) {
    formKey = input;
  }

  void reset() {
    props.forEach((prop) {
      print('clearing $prop');
      prop = null;
    });
  }
}

typedef ProviderBuilder = Widget Function(
  BuildContext context,
  FormProvider provider,
  ThemeData theme,
  BoxConstraints constraints,
);

class FormProviderWidget extends StatelessWidget {
  final ProviderBuilder builder;
  final bool listen;

  FormProviderWidget({
    @required this.builder,
    this.listen = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider.value(
          value: FormProvider(),
          builder: (context, child) {
            final provider = Provider.of<FormProvider>(context, listen: listen);
            provider.setTheme(theme);
            return builder(context, provider, theme, constraints);
          },
        );
      },
    );
  }
}

class FormProviderWidgetConsumerWidget extends StatelessWidget {
  final ProviderBuilder formBuilder;
  final GlobalKey<FormState> formKey;
  FormProviderWidgetConsumerWidget({
    @required this.formBuilder,
    @required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context);
    final ThemeData theme = provider.theme;
    return LayoutBuilder(builder: (context, constraints) {
      print('creating new form $formKey');
      provider.setFormKey(formKey);
      return Form(
        key: provider.formKey,
        child: formBuilder(context, provider, theme, constraints),
      );
    });
  }
}
