import 'dart:typed_data';
import 'dart:ui' show Image, instantiateImageCodec;

import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/lyrics.dart';
import '../model/song.dart';
import '../repository/lyrics_repository.dart';
import '../repository/song_info_repository.dart';
import 'states/lyric_select_state.dart';

part 'song_info_pods.g.dart';

@riverpod
class SongId extends _$SongId {
  @override
  int? build() {
    ref.keepAlive();
    return null;
  }

  update(int songId) => state = songId;
}

@riverpod
Future<Song> songInfo(SongInfoRef ref) async {
  final songInfoRepo = ref.watch(SongInfoRepository.pod);
  final songId = ref.watch(songIdPod);

  if (songId == null) throw StateError('no song id provided');

  final songInfo = await songInfoRepo.getSongInfoById(songId);

  ref.keepAlive();

  return songInfo;
}

@riverpod
Future<TranslatedLyrics> lyrics(LyricsRef ref) async {
  final lyricsRepo = ref.watch(LyricsRepository.pod);
  final songId = ref.watch(songIdPod);

  if (songId == null) {
    throw StateError('no song id provided');
  }

  final lyrics = await lyricsRepo.getTranslatedLyricsBySongId(songId);

  ref.keepAlive();

  return lyrics;
}

@riverpod
class LyricSelectList extends _$LyricSelectList {
  @override
  List<LyricSelectState> build() {
    final lyricsSelect = ref.watch(lyricsPod);
    ref.keepAlive();
    return (lyricsSelect.value?.lyrics ?? <TranslatedLyric>[])
        .map((lyric) => LyricSelectState(lyric: lyric, selected: false))
        .toList();
  }

  void toggle(Duration time) {
    state = [
      for (final lyricSelect in state)
        if (lyricSelect.lyric.time == time)
          lyricSelect.copyWith(selected: !lyricSelect.selected)
        else
          lyricSelect
    ];
  }
}

@riverpod
Iterable<TranslatedLyric> selectedLyrics(SelectedLyricsRef ref) {
  final lyricSelectList = ref.watch(lyricSelectListPod);
  ref.keepAlive();
  return lyricSelectList
      .where((lyricSelect) => lyricSelect.selected)
      .map((lyricSelect) => lyricSelect.lyric);
}

@riverpod
Future<Uint8List> albumCover(AlbumCoverRef ref) async {
  final songInfoFuture = ref.watch(songInfoPod.future);

  final songInfo = await songInfoFuture;
  final res = await get(Uri.parse(songInfo.album.pictureUrl));

  ref.keepAlive();

  return res.bodyBytes;
}

@riverpod
Future<Image> coverImage(CoverImageRef ref) async {
  final bytesFuture = ref.watch(albumCoverPod.future);
  final bytes = await bytesFuture;
  final codec = await instantiateImageCodec(bytes);
  final frameInfo = await codec.getNextFrame();
  final image = frameInfo.image;

  ref.onDispose(image.dispose);
  ref.keepAlive();

  return image;
}
