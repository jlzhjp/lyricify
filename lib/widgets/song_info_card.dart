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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.songInfo.name, style: textTheme.headline6),
            Text(
              widget.songInfo.album.name,
              style: textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
