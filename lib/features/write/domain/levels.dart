import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/write/domain/entitities/level.dart';

final List<Level> levels = [
  Level(
    label: 'persons',
    completed: false, // take this from sqlite
    stars: 0, // take this from sqlite,
    words: _buildListOfInstanceFromWords(
      ['man', 'woman', 'kid', 'son', 'daughter'],
    ),
    timePerWord: 20,
  ),
  Level(
    label: 'time',
    completed: false, // take this from sqlite
    stars: 0, // take this from sqlite,
    words: _buildListOfInstanceFromWords(
      ['today', 'yesterday', 'tomorrow', '', 'daughter'],
    ),
    timePerWord: 20,
  ),
  Level(
    label: 'food',
    completed: false,
    stars: 0,
    words: _buildListOfInstanceFromWords(
        ['apple', 'banana', 'meat', 'fish', 'nuts']),
    timePerWord: 20,
  ),
];

List<Mc> _buildListOfInstanceFromWords(List<String> words) {
  return words.map((w) => Mc.fromLetters(w)).toList(growable: false);
}
