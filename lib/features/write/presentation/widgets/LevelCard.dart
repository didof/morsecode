import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morsecode/core/injector_container.dart';
import 'package:morsecode/features/write/presentation/cubit/write_cubit.dart';
import 'package:morsecode/features/write/presentation/level_screen.dart';

class LevelCard extends StatelessWidget {
  final int index;
  final String label;
  final bool completed;
  final int stars;
  LevelCard({
    @required this.index,
    @required this.label,
    @required this.completed,
    @required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(label),
            Text(index.toString()),
            Text(completed ? 'completed' : 'to do'),
            Row(children: List.generate(stars, (index) => Icon(Icons.star)))
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(15.0),
      splashColor: theme.accentColor,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
            value: sl<WriteCubit>(),
            child: LevelWriteScreen(index),
          );
        }));
      },
    );
  }
}
