import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/write/presentation/cubit/write_cubit.dart';
import 'package:morsecode/widgets/LoadingDisplay.dart';

class WriteSetupUI extends StatefulWidget {
  final int i;
  final String message;
  const WriteSetupUI(this.i, {@required this.message});

  @override
  _WriteSetupUIState createState() => _WriteSetupUIState();
}

class _WriteSetupUIState extends State<WriteSetupUI> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => BlocProvider.of<WriteCubit>(context).setup(levelIndex: widget.i),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingDisplay(message: widget.message);
  }
}
