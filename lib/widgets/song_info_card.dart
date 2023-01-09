import 'package:flutter/material.dart';

import '../model/song.dart';

class SongInfoCard extends StatefulWidget {
  final Song songInfo;
  final Widget albumCover;

  const SongInfoCard({
    super.key,
    required this.albumCover,
    required this.songInfo,
  });

  @override
  State<SongInfoCard> createState() => _SongInfoCardState();
}

class _SongInfoCardState extends State<SongInfoCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.songInfo.name, style: textTheme.headline5),
            Opacity(
              opacity: 0.6,
              child: Text(
                widget.songInfo.album.name,
                style: textTheme.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
