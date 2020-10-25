import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';
import 'package:morsecode/widgets/button.dart';
import 'package:morsecode/widgets/text_field.dart';

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
  bool _switchValue;
  double _sliderValue;

  @override
  void initState() {
    _textFieldController = TextEditingController();
    _switchValue = false;
    _sliderValue = 1;
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
      cubit.getStreamBoolFromWord(
        word: _textFieldController.text,
        lamp: _switchValue,
        streamSpeed: streamSpeed,
      );
    }
  }

  StreamSpeed get streamSpeed {
    if (_sliderValue <= 1) {
      return StreamSpeed.slow;
    } else if (_sliderValue <= 2) {
      return StreamSpeed.medium;
    }
    return StreamSpeed.fast;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: CustomTextField(
            controller: _textFieldController,
          ),
        ),
        SwitchListTile(
          title: const Text('Light'),
          value: _switchValue,
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
          },
        ),
        ListTile(
          title: const Text('Speed'),
          subtitle: Slider(
            value: _sliderValue,
            divisions: 2,
            label: _sliderValue.floor().toString(),
            min: 1,
            max: 3,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),
        OnOffButton(
          currentLampState: widget.currentLampState,
          dispatch: dispatchEvent,
        ),
        FlatButton(
          child: const Text('test'),
          onPressed: () => print(streamSpeed),
        )
      ],
    );
  }
}

enum StreamSpeed {
  slow,
  medium,
  fast,
}
