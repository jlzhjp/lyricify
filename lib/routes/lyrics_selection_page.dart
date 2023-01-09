import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/song_info_pods.dart';
import 'editor_page.dart';
import '../widgets/blurred_image_background.dart';
import '../widgets/lyric_item.dart';
import '../widgets/song_info_card.dart';

class LyricsSelectionPage extends StatefulWidget {
  const LyricsSelectionPage({super.key});

  @override
  State<LyricsSelectionPage> createState() => _LyricsSelectionPageState();
}

class _LyricsSelectionPageState extends State<LyricsSelectionPage> {
  Widget _buildLoadingIndicator(
      BuildContext context, WidgetRef ref, Widget? child) {
    final albumCover = ref.watch(albumCoverPod);
    final lyrics = ref.watch(lyricsPod);

    if (lyrics.isLoading || albumCover.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container();
  }

  Widget _buildCoverImage(BuildContext context, WidgetRef ref, Widget? child) {
    final albumCover = ref.watch(albumCoverPod);

    return albumCover.when(
        data: (imageBytes) => FadeIn(
              child: Image.memory(
                imageBytes,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),
        error: (error, stackTrace) => Container(),
        loading: () => Container());
  }

  Widget _buildSongInfoCard(
      BuildContext context, WidgetRef ref, Widget? child) {
    final songInfo = ref.watch(songInfoPod);

    return songInfo.when(
        data: (songInfo) => FadeIn(
              child: SongInfoCard(
                  albumCover: Consumer(builder: _buildCoverImage),
                  songInfo: songInfo),
            ),
        error: (error, stackTrace) =>
            Card(child: Center(child: Text(error.toString()))),
        loading: () => Container());
  }

  Widget _buildLyricsList(BuildContext context, WidgetRef ref, Widget? child) {
    final lyrics = ref.watch(lyricsPod);
    final lyricSelectListState = ref.watch(lyricSelectListPod);
    final lyricSelectListStateNotifier = ref.read(lyricSelectListPod.notifier);

    return lyrics.when(
        data: (lyrics) => FadeIn(
              child: ListView(children: [
                for (final lyricSelect in lyricSelectListState)
                  LyricItem(
                    lyric: lyricSelect.lyric,
                    isSelected: lyricSelect.selected,
                    onSelectChange: (isSelected, lyric) =>
                        lyricSelectListStateNotifier.toggle(lyric.time),
                  )
              ]),
            ),
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  void _onOkButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const EditorPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择歌词"),
        actions: [Consumer(builder: _buildLoadingIndicator)],
      ),
      body: Stack(children: [
        Positioned.fill(
            child: BlurredImageBackground(
                image: Consumer(builder: _buildCoverImage))),
        Positioned.fill(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Consumer(builder: _buildSongInfoCard),
              Expanded(child: Consumer(builder: _buildLyricsList)),
            ])),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _onOkButtonPressed,
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
