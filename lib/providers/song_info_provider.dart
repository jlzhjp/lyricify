import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyricify/providers/song_id_provider.dart';
import 'package:lyricify/repository/song_info_repository.dart';

final songInfoProvider = FutureProvider((ref) async {
  final songInfoRepo = ref.read(SongInfoRepository.provider);
  final songId = ref.read(songIdProvider);

  return await songInfoRepo.getSongInfoById(songId);
});
