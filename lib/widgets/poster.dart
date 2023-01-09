import 'dart:math';
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyricify/extensions/rect.dart';
import 'package:lyricify/providers/editor_pods.dart';

import '../model/lyrics.dart';
import '../providers/song_info_pods.dart';
import '../providers/states/background_config_state.dart';

class Poster extends StatelessWidget {
  const Poster({super.key});

  Widget _buildPoster(BuildContext context, WidgetRef ref, Widget? child) {
    final coverImage = ref.watch(coverImagePod);
    final selectedLyrics = ref.watch(selectedLyricsPod);
    final backgroundConfigState = ref.watch(backgroundConfigPod);

    return coverImage.when(
      data: (image) => CustomPaint(
        painter: PosterPainter(
            coverImage: image,
            translatedLyrics: selectedLyrics,
            backgroundConfig: backgroundConfigState),
      ),
      loading: () =>
          const Card(child: Center(child: CircularProgressIndicator())),
      error: ((error, stackTrace) =>
          Card(child: Center(child: Text(error.toString())))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: _buildPoster);
  }
}

class PosterPainter extends CustomPainter with EquatableMixin {
  final ui.Image coverImage;
  final Iterable<TranslatedLyric> translatedLyrics;
  final BackgroundConfigState backgroundConfig;

  PosterPainter({
    required this.coverImage,
    required this.translatedLyrics,
    required this.backgroundConfig,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(size.rectFromOrigin);

    final coverSize = min(size.width, size.height);
    const padding = 20;

    if (backgroundConfig.type == BackgroundType.image) {
      canvas.drawImageRect(coverImage, coverImage.fullRect, size.rectFromOrigin,
          Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40));
    } else if (backgroundConfig.type == BackgroundType.color) {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()..color = backgroundConfig.backgroundColor);
    }

    canvas.drawImageRect(
        coverImage,
        coverImage.fullRect,
        Rect.fromCenter(
            center: Offset(coverSize / 2, coverSize / 2),
            width: coverSize - padding * 2,
            height: coverSize - padding * 2),
        Paint());

    int i = 0;

    for (final lyric in translatedLyrics) {
      final text = TextSpan(text: lyric.text);
      TextPainter textPainter = TextPainter(
          text: text,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: size.width - padding * 2);
      textPainter.paint(
          canvas, Offset(padding.toDouble(), padding * 2 + coverSize + i * 20));
      ++i;
    }
  }

  @override
  bool shouldRepaint(covariant PosterPainter oldDelegate) {
    return oldDelegate == this;
  }

  @override
  List<Object?> get props => [coverImage, translatedLyrics, backgroundConfig];
}
