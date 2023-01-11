/// 与歌曲信息有关的 Provider
///
/// 因为基本整个应用都要使用, 所以大部分设置了 [keepAlive], 防止被销毁
/// 因为 Provider 名字比较长, 所以在代码生成器的配置中将后缀改为了 'Pod', 这样还可以
/// 避免跟 provider 包中的概念产生混淆
///
/// Provider 间的依赖关系:
///
///         +--->songInfo--->albumCover--->coverImage
///         |
/// songId--+
///         +--->lyrics--->lyricSelectList->selectedLyrics

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

/// 歌曲的 ID, 默认为空, 如果没有更新 ID 就调用其他方法会抛出异常 [StateError]
///
/// 尝试过官方 example 里面为了避免可空类型采用的的写法, 即在 Provider 定义中抛出
/// `UnimplementedError` 再在路由里面创建一个新的 `ProviderScope`,使用 `overrides`
/// 将其重写为指定的 id
///
/// ```dart
/// if (settings.name!.startsWith('/characters/') && split.length == 3) {
///   result = ProviderScope(
///     overrides: [
///       selectedCharacterId.overrideWithValue(split.last),
///     ],
///     child: const CharacterView(),
///   );
/// }
/// ```
/// https://github.com/rrousselGit/riverpod/blob/2b1a2dcfafefe4388600b701a476e108dc44c205/examples/marvel/lib/main.dart#L46
///
/// 但是这样 `ProviderScope` 就只能覆盖到一个 Screen, 从歌词选择界面跳转到编辑器界面
/// 的时候状态无法保存. 所以最后还是用了可空类型.

@riverpod
class SongId extends _$SongId {
  @override
  int? build() {
    ref.keepAlive();
    return null;
  }

  void update(int songId) => state = songId;
}

/// 歌曲信息
///
/// 当 songId 变化时自动刷新
@riverpod
Future<Song> songInfo(SongInfoRef ref) async {
  final songInfoRepo = ref.watch(SongInfoRepository.pod);
  final songId = ref.watch(songIdPod);

  if (songId == null) {
    throw StateError('no song id provided');
  }

  final songInfo = await songInfoRepo.getSongInfoById(songId);

  ref.keepAlive();

  return songInfo;
}

/// 歌曲的歌词
///
/// 同样当 songId 变化时自动刷新
/// TODO: 支持 `CancelToken`
@riverpod
Future<TranslatedLyrics> lyrics(LyricsRef ref) async {
  final lyricsRepo = ref.watch(LyricsRepository.pod);
  final songId = ref.watch(songIdPod);

  if (songId == null) {
    throw StateError('no song id provided');
  }

  final lyrics = await lyricsRepo.getTranslatedLyricsBySongId(songId);

  // 只有成功了才 keepAlive. 如果发生异常的话没必要保存状态
  ref.keepAlive();

  return lyrics;
}

/// 维护一个列表, 在 [TranslatedLyric] 上额外维护一个 `selected` 属性, 表示当前歌词
/// 是否被选中
/// see also: [LyricSelectState]
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

  /// 切换某一时间歌词的选中状态
  ///
  /// 因为每句歌词的时间肯定一唯一的, 所以这里直接用 `time` 当作 ID 来用了
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

/// 获取用户所选中的歌词
///
/// 把 lyricSelectList 中的内容筛选一下
@riverpod
Iterable<TranslatedLyric> selectedLyrics(SelectedLyricsRef ref) {
  final lyricSelectList = ref.watch(lyricSelectListPod);

  ref.keepAlive();
  return lyricSelectList
      .where((lyricSelect) => lyricSelect.selected)
      .map((lyricSelect) => lyricSelect.lyric);
}

/// 获取歌曲专辑封面图片的 bytes
@riverpod
Future<Uint8List> albumCover(AlbumCoverRef ref) async {
  final songInfoFuture = ref.watch(songInfoPod.future);

  final songInfo = await songInfoFuture;
  final res = await get(Uri.parse(songInfo.album.pictureUrl));

  ref.keepAlive();

  return res.bodyBytes;
}

/// 将图片的 bytes 转换为 [Image], 方便在 [CustomPaint] 上绘图
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
