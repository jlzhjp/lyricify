import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:lyricify/providers/song_info_provider.dart';

final albumCoverProvider = FutureProvider((ref) async {
  final songInfoFuture = ref.watch(songInfoProvider.future);

  final songInfo = await songInfoFuture;
  final res = await get(Uri.parse(songInfo.album.pictureUrl));
  return res.bodyBytes;
});
