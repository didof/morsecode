import 'package:meta/meta.dart';
import 'package:morsecode/features/converter/domain/entitities/Mc.dart';

class Level {
  final String label;
  final List<Mc> words;
  final bool completed;
  final int stars;
  final int timePerWord;
  Level({
    @required this.label,
    @required this.words,
    @required this.completed,
    @required this.stars,
    @required this.timePerWord,
  });
}
