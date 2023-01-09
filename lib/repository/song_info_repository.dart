import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../model/song.dart';

class SongInfoRepository {
  static final pod =
      Provider<SongInfoRepository>((ref) => SongInfoRepository());

  Future<Song> getSongInfoById(int songId) async {
    final res = await get(
        Uri.parse('http://music.163.com/api/song/detail?ids=[$songId]'));
    final jsonMap = await json.decode(res.body);
    final song = Song.fromJson(jsonMap['songs'].first as Map<String, dynamic>);
    return song;
  }
}
