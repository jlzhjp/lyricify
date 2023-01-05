import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyricify/providers/song_id_provider.dart';
import 'package:lyricify/repository/lyrics_repository.dart';

final lyricsProvider = FutureProvider((ref) async {
  final lyricsRepo = ref.read(LyricsRepository.provder);
  final songId = ref.read(songIdProvider);

  return await lyricsRepo.getTranslatedLyricsBySongId(songId);
});
