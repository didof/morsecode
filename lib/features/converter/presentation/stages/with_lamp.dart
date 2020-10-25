import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';

/// UI that presents a [TextField] and a [Button]. If the former is empty, the
/// pressing of [Button] will toggle the device camera light.
/// If the [TextField] is not empty, the domain will build a [Stream<bool>]
/// translating the text into morsecode and this will be passed to a different
/// interface ([ConverterWithStreamUI]).
class ConverterActiveWithLampUI extends StatefulWidget {
  final LampState currentLampState;
  ConverterActiveWithLampUI({@required this.currentLampState});

  @override
  _ConverterActiveWithLampUIState createState() =>
      _ConverterActiveWithLampUIState();
}

class _ConverterActiveWithLampUIState extends State<ConverterActiveWithLampUI> {
  TextEditingController _textFieldController;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  // dispatchers
  void dispatchEvent() {
    final cubit = context.bloc<ConverterCubit>();

    if (_textFieldController.text.isEmpty) {
      cubit.invertLampState(currentLampState: widget.currentLampState);
    } else {
      cubit.getStreamBoolFromWord(word: _textFieldController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          currentLampState: widget.currentLampState,
          dispatch: dispatchEvent,
        ),
        Padding(
            padding: const EdgeInsets.all(32.0),
            child: CustomTextField(controller: _textFieldController)),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({@required this.controller});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: theme.primaryColor,
          ),
        ),
        filled: true,
        fillColor: theme.primaryColorLight,
      ),
      maxLength: 5,
      cursorColor: theme.primaryColor,
      autofocus: true,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
    );
  }
}

class CustomButton extends StatelessWidget {
  final LampState currentLampState;
  final Function dispatch;
  const CustomButton({
    @required this.currentLampState,
    @required this.dispatch,
  });

  // getters
  Widget get lampButtonText =>
      currentLampState == LampState.off ? const Text('ON') : const Text('OFF');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FlatButton(
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: theme.primaryColor),
      ),
      splashColor: theme.accentColor,
      padding: const EdgeInsets.all(16.0),
      textColor: Colors.white,
      child: lampButtonText,
      onPressed: dispatch,
    );
  }
}
