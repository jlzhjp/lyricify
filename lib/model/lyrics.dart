import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class Lyric with EquatableMixin {
  final Duration time;
  final String text;

  const Lyric({required this.time, required this.text});

  @override
  get props => [time, text];
}

class Lyrics {
  List<Lyric> lyrics = [];

  static final lyricRegex = RegExp(
      '\\[(?<min>\\d{2}):(?<sec>\\d{2})\\.(?<ms>\\d+)\\](?<text>[^\\[]*)');

  Lyrics.fromLrc(String lrc) {
    final matches = lyricRegex.allMatches(lrc);
    for (final match in matches) {
      final min = match.namedGroup('min');
      final sec = match.namedGroup('sec');
      final ms = match.namedGroup('ms');
      final text = match.namedGroup('text')?.trim();

      if (min == null || sec == null || ms == null || text == null) {
        throw const FormatException('invalid lrc string');
      }

      final minutes = int.parse(min);
      final seconds = int.parse(sec);
      final milliseconds = int.parse(ms);

      lyrics.add(Lyric(
        time: Duration(
            minutes: minutes, seconds: seconds, milliseconds: milliseconds),
        text: text,
      ));
    }
  }
}

class TranslatedLyric extends Lyric with EquatableMixin {
  final String? tranlation;

  const TranslatedLyric({
    required super.time,
    required super.text,
    this.tranlation,
  });

  @override
  get props => [time, text, tranlation];
}

class TranslatedLyrics {
  final List<TranslatedLyric> lyrics = [];

  TranslatedLyrics(Lyrics originalLyrics, Lyrics tranlatedLyrics) {
    for (final originalLyric in originalLyrics.lyrics) {
      int pos = binarySearch(tranlatedLyrics.lyrics, originalLyric,
          compare: (lhs, rhs) => lhs.time.compareTo(rhs.time));
      late String? tranlation;
      if (pos < 0) {
        tranlation = null;
      } else {
        tranlation = tranlatedLyrics.lyrics[pos].text;
      }
      lyrics.add(TranslatedLyric(
        time: originalLyric.time,
        text: originalLyric.text,
        tranlation: tranlation,
      ));
    }
  }
}
