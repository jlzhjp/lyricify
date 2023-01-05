import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lyricify/providers/album_cover_provider.dart';
import 'package:lyricify/providers/lyrics_provider.dart';
import 'package:lyricify/providers/song_id_provider.dart';
import 'package:lyricify/providers/song_info_provider.dart';
import 'package:lyricify/widgets/blurred_image_background.dart';
import 'package:lyricify/widgets/lyric_item.dart';
import 'package:lyricify/widgets/song_info_card.dart';

class LyricsSelectionPage extends StatefulWidget {
  final int songId;
  const LyricsSelectionPage({super.key, required this.songId});

  @override
  State<LyricsSelectionPage> createState() => _LyricsSelectionPageState();
}

class _LyricsSelectionPageState extends State<LyricsSelectionPage> {
  Widget _buildLoadingIndicator() {
    return Consumer(builder: (context, ref, child) {
      final albumCover = ref.watch(albumCoverProvider);
      final lyrics = ref.watch(lyricsProvider);

      if (lyrics.isLoading || albumCover.isLoading) {
        return const CircularProgressIndicator(
          color: Colors.white,
        );
      }
      return Container();
    });
  }

  Widget _buildCoverImage() {
    return Consumer(builder: (context, ref, child) {
      final albumCover = ref.watch(albumCoverProvider);

      return albumCover.when(
          data: (imageBytes) => Image.memory(
                imageBytes,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
          error: (error, stackTrace) => const Card(),
          loading: () => const Card());
    });
  }

  Widget _buildSongInfoCard() {
    return Consumer(builder: (context, ref, child) {
      final songInfo = ref.watch(songInfoProvider);

      return songInfo.when(
          data: (songInfo) =>
              SongInfoCard(albumCover: _buildCoverImage(), songInfo: songInfo),
          error: (error, stackTrace) =>
              Card(child: Center(child: Text(error.toString()))),
          loading: () =>
              const Card(child: Center(child: CircularProgressIndicator())));
    });
  }

  Widget _buildLyricsList() {
    return Consumer(builder: (context, ref, child) {
      final lyrics = ref.watch(lyricsProvider);

      return lyrics.when(
          data: (lyrics) => ListView(children: [
                for (final lyric in lyrics.lyrics) LyricItem(lyric: lyric)
              ]),
          error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [songIdProvider.overrideWithValue(widget.songId)],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("选择歌词"),
          actions: [_buildLoadingIndicator()],
        ),
        body: Stack(children: [
          Positioned.fill(
              child: BlurredImageBackground(image: _buildCoverImage())),
          Positioned.fill(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                _buildSongInfoCard(),
                Expanded(child: _buildLyricsList())
              ])),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.check_rounded),
        ),
      ),
    );
  }
}
