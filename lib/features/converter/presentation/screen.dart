import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/converter/data/lamp_interface.dart';
import 'package:morsecode/features/converter/data/repository_impl.dart';
import 'package:morsecode/features/converter/domain/usecases/use_hasLamp.dart';
import 'package:morsecode/features/converter/domain/usecases/use_invertLampState.dart';
import 'package:morsecode/features/converter/domain/usecases/use_pauseLampStream.dart';
import 'package:morsecode/features/converter/domain/usecases/use_playLampStream.dart';
import 'package:morsecode/features/converter/domain/usecases/use_setLampState.dart';
import 'package:morsecode/features/converter/domain/usecases/use_getStreamBoolFromWord.dart';
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
      create: (context) => ConverterCubit(
        useHasLamp: UseHasLamp(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
        useInvertLampState: UseInvertLampState(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
        useSetLampState: UseSetLampState(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
        useInstantiateMcFromWord: UseInstantiateMcFromWord(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
        usePlayLampStream: UsePlayLampStream(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
        usePauseLampStream: UsePauseLampStream(
          repository: ConverterRepositoryImpl(
            lampInterface: LampInterfaceImpl(),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Converter'),
        ),
        body: ConverterBody(),
      ),
    );
  }
}

class ConverterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConverterCubit, ConverterState>(
      listener: (context, state) {
        if (state is ConverterWithStream) {
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
          return ConverterActiveWithLampUI(currentLampState: state.lampState);
        if (state is ConverterWithoutLamp)
          return ConverterActiveWithoutLampUI();
        if (state is ConverterWithStream)
          return ConverterWithStreamUI(word: state.word, stream: state.stream);

        return Text('error');
      },
    );
  }
}
