import 'package:flutter/material.dart';
import 'package:morsecode/features/write/domain/entitities/level.dart';
import 'package:morsecode/features/write/domain/levels.dart';
import 'package:morsecode/features/write/presentation/widgets/LevelCard.dart';

class WriteScreen extends StatelessWidget {
  final AppBar appBar = AppBar(
    title: const Text('Write'),
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar,
      backgroundColor: theme.primaryColorLight,
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(16.0),
          children: generateLevelCards(levels),
        ),
      ),
    );
  }
}

List<LevelCard> generateLevelCards(List<Level> levels) {
  List<LevelCard> output = [];
  for (var i = 0; i < levels.length; i++) {
    final l = levels[i];
    final card = LevelCard(
      index: i,
      label: l.label,
      completed: l.completed,
      stars: l.stars,
    );
    output.add(card);
  }
  return output;
}
