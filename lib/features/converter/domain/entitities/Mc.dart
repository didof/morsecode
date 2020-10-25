import 'package:meta/meta.dart';
import 'package:morsecode/features/converter/domain/tuples.dart';
import 'package:morsecode/features/converter/presentation/stages/with_lamp.dart';

class Mc {
  final String word;
  final List<String> morsecode;

  Mc({this.word, this.morsecode});

  static List<String> generateMorsecode(String word) {
    return List.generate(word.length, (i) {
      return TUPLES[word[i].toUpperCase()] + ' ';
    });
  }

  static String generateWord(List<String> morsecode) {
    return morsecode
        .map((el) {
          return TUPLES.keys.firstWhere((key) => TUPLES[key] == el);
        })
        .join()
        .toString();
  }

  factory Mc.fromLetters(String word) {
    final morsecode = generateMorsecode(word);
    return Mc(word: word, morsecode: morsecode);
  }

  factory Mc.fromMorsecode(List<String> morsecode) {
    final word = generateWord(morsecode);
    return Mc(word: word, morsecode: morsecode);
  }

  List<String> get props => [word, morsecode.join()];

  Stream<bool> streamMorsecodeToBool({
    @required StreamSpeed streamSpeed,
  }) async* {
    print('[asyncronizeMorsecodeToBool] called with morsecode:$morsecode');
    final stringified = morsecode.join(" ");
    final durations = buildDurationsSet(streamSpeed);

    for (var i = 0; i < stringified.length; i++) {
      if (stringified[i] != ' ') {
        yield true;
        await Future.delayed(Duration(milliseconds: durations[stringified[i]]));
        yield false;
        await Future.delayed(Duration(milliseconds: durations['|']));
      } else
        yield false;
    }
  }
}

Map<String, int> buildDurationsSet(StreamSpeed speed) {
  const durationsSlow = const {
    '|': 500,
    '.': 500,
    '-': 1000,
    ' ': 2000,
  };
  const durationsMedium = const {
    '|': 1000,
    '.': 1000,
    '-': 2000,
    ' ': 4000,
  };
  const durationsFast = const {
    '|': 2000,
    '.': 2000,
    '-': 4000,
    ' ': 8000,
  };

  if (speed == StreamSpeed.medium) {
    return durationsMedium;
  } else if (speed == StreamSpeed.slow) {
    return durationsSlow;
  }
  return durationsFast;
}

const durations = const {
  '|': 500,
  '.': 500,
  '-': 1000,
  ' ': 2000,
};

List<Map<String, List<String>>> generateToupleWords(List<String> words) {
  final Map<String, List<String>> maps = Map.fromIterable(words,
      key: (el) => el, value: (el) => Mc.generateMorsecode(el));
  return maps.entries.map((el) {
    return {el.key: el.value};
  }).toList();
}
