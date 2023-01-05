import 'package:flutter/material.dart';
import 'package:lyricify/model/lyrics.dart';
// 2003496927

class LyricItem extends StatelessWidget {
  final TranslatedLyric lyric;
  const LyricItem({super.key, required this.lyric});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(lyric.text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          if (lyric.tranlation != null)
            Text(
              lyric.tranlation!,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
        ],
      ),
    );
  }
}
