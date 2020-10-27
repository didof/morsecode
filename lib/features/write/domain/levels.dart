import 'package:morsecode/features/converter/domain/entitities/Mc.dart';
import 'package:morsecode/features/write/domain/entitities/level.dart';

final List<Level> levels = [
  Level(
    label: 'numbers',
    completed: false, // take this from sqlite
    stars: 0, // take this from sqlite,
    words: _buildListOfInstanceFromWords(
      ['1', '2', '3', '4', '5'],
    ),
  ),
  Level(
    label: 'persons',
    completed: false, // take this from sqlite
    stars: 0, // take this from sqlite,
    words: _buildListOfInstanceFromWords(
      ['man', 'woman', 'kid', 'son', 'daughter'],
    ),
  ),
  Level(
    label: 'time',
    completed: false, // take this from sqlite
    stars: 0, // take this from sqlite,
    words: _buildListOfInstanceFromWords(
      ['today', 'yesterday', 'tomorrow', '', 'daughter'],
    ),
  ),
  Level(
    label: 'food',
    completed: false,
    stars: 0,
    words: _buildListOfInstanceFromWords(
        ['apple', 'banana', 'meat', 'fish', 'nuts']),
  ),
];

List<Mc> _buildListOfInstanceFromWords(List<String> words) {
  return words.map((w) => Mc.fromLetters(w)).toList(growable: false);
}
