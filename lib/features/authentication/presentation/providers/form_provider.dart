import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Fields {
  Email,
  Password,
}

class FormProvider with ChangeNotifier {
  GlobalKey<FormState> formKey;

  ThemeData theme;
  String email;
  String password;

  bool isWaiting = false;

  FormProvider({
    this.email,
    this.password,
  });

  List<dynamic> get props => [formKey, theme, email, password];

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

  void readValues() {
    props.forEach((prop) {
      if (props != null) print('read: prop{$prop}');
    });
  }

  void saveValues() {
    formKey.currentState.save();
    isWaiting = true;
    notifyListeners();
    mockRequest();
  }

  Future<void> mockRequest() async {
    Future.delayed(Duration(milliseconds: 500), () {
      isWaiting = false;
      notifyListeners();
    });
  }

  void setValue(Fields field, String value) {
    switch (field) {
      case Fields.Email:
        email = value;
        break;
      case Fields.Password:
        password = value;
        break;
      default:
    }
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
  final String email;
  final String password;

  FormProviderWidgetConsumerWidget({
    @required this.formBuilder,
    @required this.formKey,
    this.email,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context);
    final ThemeData theme = provider.theme;
    return LayoutBuilder(builder: (context, constraints) {
      provider.setFormKey(formKey);
      return Form(
        key: provider.formKey,
        child: formBuilder(context, provider, theme, constraints),
      );
    });
  }
}

class FormProviderAccess extends StatelessWidget {
  final Widget Function(BuildContext context, FormProvider provider) builder;
  FormProviderAccess({@required this.builder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context);
    return builder(context, provider);
  }
}
