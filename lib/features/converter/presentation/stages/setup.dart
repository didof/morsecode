import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';

class ConverterSetupUI extends StatefulWidget {
  final Widget display;
  ConverterSetupUI({@required this.display});

  @override
  _ConverterSetupUIState createState() => _ConverterSetupUIState();
}

class _ConverterSetupUIState extends State<ConverterSetupUI> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => BlocProvider.of<ConverterCubit>(context).setup(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.display;
  }
}
