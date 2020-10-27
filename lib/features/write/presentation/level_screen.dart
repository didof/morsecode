import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/write/presentation/cubit/write_cubit.dart';
import 'package:morsecode/features/write/presentation/stages/setup.dart';

class LevelWriteScreen extends StatelessWidget {
  final int i;
  LevelWriteScreen(this.i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${i.toString()}'),
      ),
      body: BlocConsumer<WriteCubit, WriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(state);
          if (state is WriteSetup) {
            return WriteSetupUI(i, message: state.message);
          }
          if (state is WriteActive) {
            return Text(state.instance.word);
          }
        },
      ),
    );
  }
}
