import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';

class ConverterWithStreamUI extends StatelessWidget {
  final String word;
  final Stream<bool> stream;
  ConverterWithStreamUI({
    @required this.word,
    @required this.stream,
  });

  void dispatchBack(BuildContext context) {
    print('[dispatchBack]');
    BlocProvider.of<ConverterCubit>(context).resetToWithLampUI(
      streamBool: stream,
    );
  }

  void dispatchRepeat(BuildContext context) {
    print('[dispatchRepeat]');
    BlocProvider.of<ConverterCubit>(context).getStreamBoolFromWord(
      word: word,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(word),
          StreamBuilder<bool>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData)
                  return Active(
                    isOn: snapshot.data,
                    onCancel: () => dispatchBack(context),
                  );
              }
              if (snapshot.connectionState == ConnectionState.done)
                return Done(
                  onRepeat: () => dispatchRepeat(context),
                  onReset: () => dispatchBack(context),
                );
              return CircleAvatar(
                backgroundColor: Colors.red,
              );
            },
          ),
        ],
      ),
    );
  }
}

class Done extends StatelessWidget {
  final Function onRepeat;
  final Function onReset;
  const Done({@required this.onRepeat, @required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: Colors.blue),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: const Icon(Icons.chevron_left),
              label: const Text('CHANGE'),
              onPressed: onReset,
            ),
            OutlineButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('REPEAT'),
              onPressed: onRepeat,
            ),
          ],
        ),
      ],
    );
  }
}

class Active extends StatelessWidget {
  final bool isOn;
  final Function onCancel;
  const Active({
    @required this.isOn,
    @required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: isOn ? Colors.yellow : Colors.black),
        FlatButton.icon(
          icon: const Icon(Icons.chevron_left),
          label: const Text('CANCEL'),
          onPressed: onCancel,
        ),
      ],
    );
  }
}
