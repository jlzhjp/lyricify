import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:lyricify/model/lyrics.dart';

class LyricsRepository {
  static final provder = Provider((ref) => LyricsRepository());

  Future<TranslatedLyrics> getTranslatedLyricsBySongId(int songId) async {
    final res = await get(Uri.parse(
        'http://music.163.com/api/song/lyric?id=$songId&lv=-1&tv=-1'));
    final jsonText = res.body;
    final jsonMap = await json.decode(jsonText);

    String originalLrcString = jsonMap['lrc']['lyric'];
    String translatedLrcString = jsonMap['tlyric']['lyric'];
    Lyrics oringinal = Lyrics.fromLrc(originalLrcString);
    Lyrics tranlated = Lyrics.fromLrc(translatedLrcString);
    return TranslatedLyrics(oringinal, tranlated);
  }
}
