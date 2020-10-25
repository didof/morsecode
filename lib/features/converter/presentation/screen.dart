import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/core/injector_container.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';
import 'package:morsecode/features/converter/presentation/stages/setup.dart';
import 'package:morsecode/features/converter/presentation/stages/with_lamp.dart';
import 'package:morsecode/features/converter/presentation/stages/with_stream_UI.dart';
import 'package:morsecode/features/converter/presentation/stages/without_lamp.dart';
import 'package:morsecode/widgets/LoadingDisplay.dart';

class ConverterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ConverterCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Converter'),
        ),
        body: BlocConsumer<ConverterCubit, ConverterState>(
          listener: (context, state) {
            if (state is ConverterWithStream && state.lamp) {
              context
                  .bloc<ConverterCubit>()
                  .playLampStream(streamBool: state.stream);
            }
          },
          builder: (context, state) {
            // ? setup
            if (state is ConverterSetup)
              return ConverterSetupUI(
                  display: LoadingDisplay(message: state.message));

            // ? active
            if (state is ConverterWithLamp)
              return ConverterActiveWithLampUI(
                  currentLampState: state.lampState);
            if (state is ConverterWithoutLamp)
              return ConverterActiveWithoutLampUI();
            if (state is ConverterWithStream)
              return ConverterWithStreamUI(
                  word: state.word, stream: state.stream);

            return Text('error');
          },
        ),
      ),
    );
  }
}
