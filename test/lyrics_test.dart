import 'package:flutter_test/flutter_test.dart';
import 'package:lyricify/model/lyrics.dart';

const lrcString =
    '[00:00.000] 作曲 : Eve\n[00:24.56]思い焦がれたあの子\n[00:27.58]指さしたどの子\n';

const translationString = '[by:沙沙响的曙光]\n[00:24.56]思慕已久的那个人\n[00:27.58]指的是哪个人\n';

void main() {
  test('parse lrc format', () {
    final lyrics = Lyrics.fromLrc(lrcString);
    const expected = [
      Lyric(time: Duration(seconds: 0, milliseconds: 0), text: '作曲 : Eve'),
      Lyric(time: Duration(seconds: 24, milliseconds: 56), text: '思い焦がれたあの子'),
      Lyric(time: Duration(seconds: 27, milliseconds: 58), text: '指さしたどの子'),
    ];
    expect(lyrics.lyrics, expected);
  });

  test('with tranlation', () {
    final lyrics = Lyrics.fromLrc(lrcString);
    final translation = Lyrics.fromLrc(translationString);
    const expected = [
      TranslatedLyric(
          time: Duration(seconds: 0, milliseconds: 0),
          text: '作曲 : Eve',
          tranlation: null),
      TranslatedLyric(
          time: Duration(seconds: 24, milliseconds: 56),
          text: '思い焦がれたあの子',
          tranlation: '思慕已久的那个人'),
      TranslatedLyric(
          time: Duration(seconds: 27, milliseconds: 58),
          text: '指さしたどの子',
          tranlation: '指的是哪个人'),
    ];
    final translatedLyrics = TranslatedLyrics(lyrics, translation);
    expect(translatedLyrics.lyrics, expected);
  });
}
