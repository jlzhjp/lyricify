import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../extensions/num.dart';
import '../extensions/rect.dart';
import '../model/lyrics.dart';
import '../pods/editor_pods.dart';
import '../pods/song_info_pods.dart';
import '../pods/states/background_config_state.dart';
import '../pods/states/font_config_state.dart';
import '../pods/states/page_config_state.dart';

/// 渲染歌词海报
class Poster extends StatelessWidget {
  const Poster({super.key});

  Widget _buildPoster(BuildContext context, WidgetRef ref, Widget? child) {
    final mediaSize = MediaQuery.of(context).size;
    final coverImage = ref.watch(coverImagePod);

    final selectedLyrics = ref.watch(selectedLyricsPod);
    final backgroundConfig = ref.watch(backgroundConfigPod);
    final fontConfig = ref.watch(fontConfigPod);
    final pageConfig = ref.watch(pageConfigPod);

    return coverImage.when(
      data: (image) => CustomPaint(
        painter: PosterPainter(
          mediaSize: mediaSize,
          coverImage: image,
          translatedLyrics: selectedLyrics,
          pageConfig: pageConfig,
          backgroundConfig: backgroundConfig,
          fontConfig: fontConfig,
        ),
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

class PosterPainter extends CustomPainter {
  final Size mediaSize;
  final ui.Image coverImage;
  final Iterable<TranslatedLyric> translatedLyrics;
  final PageConfigState pageConfig;
  final BackgroundConfigState backgroundConfig;
  final FontConfigState fontConfig;

  PosterPainter({
    required this.mediaSize,
    required this.coverImage,
    required this.translatedLyrics,
    required this.pageConfig,
    required this.backgroundConfig,
    required this.fontConfig,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / mediaSize.width;
    useScale(scale);

    canvas.clipRect(size.rectFromOrigin);

    final coverSize = size.width;
    final padding = 20.sc;

    if (backgroundConfig.showBackground) {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()..color = backgroundConfig.backgroundColor);

      canvas.drawImageRect(
          coverImage,
          coverImage.fullRect,
          size.rectFromOrigin,
          Paint()
            ..imageFilter = ui.ImageFilter.blur(
                sigmaX: backgroundConfig.imageBlurSigma,
                sigmaY: backgroundConfig.imageBlurSigma,
                tileMode: TileMode.mirror)
            ..color = Color.fromRGBO(0, 0, 0, backgroundConfig.imageOpacity));
    }

    final coverRect = Rect.fromCenter(
        center: Offset(coverSize / 2, coverSize / 2),
        width: coverSize - padding * 2,
        height: coverSize - padding * 2);
    final rCoverRect =
        RRect.fromRectAndRadius(coverRect, const Radius.circular(10));

    canvas.drawShadow(Path()..addRRect(rCoverRect), Colors.black, 4, false);

    canvas.save();

    canvas.clipRRect(rCoverRect);

    canvas.drawImageRect(coverImage, coverImage.fullRect, coverRect, Paint());

    canvas.restore();

    double currentDrawingY = padding * 2 + coverSize;

    for (final lyric in translatedLyrics) {
      final text = TextSpan(
        text: lyric.text,
        style: TextStyle(
          color: fontConfig.lyricColor,
          fontSize: fontConfig.lyricFontSize.sc,
        ),
      );

      TextPainter textPainter = TextPainter(
          text: text,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      textPainter.layout(maxWidth: size.width - padding * 2);
      textPainter.paint(canvas, Offset(padding.toDouble(), currentDrawingY));

      currentDrawingY += textPainter.height;

      final translation = TextSpan(
        text: lyric.translation,
        style: TextStyle(
          color: fontConfig.translationColor,
          fontSize: fontConfig.translationFontSize.sc,
        ),
      );

      TextPainter translationPainter = TextPainter(
          text: translation,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      translationPainter.layout(maxWidth: size.width - padding * 2);
      translationPainter.paint(
          canvas, Offset(padding.toDouble(), currentDrawingY));

      currentDrawingY += translationPainter.height;

      currentDrawingY += 10.sc;
    }
  }

  @override
  bool shouldRepaint(covariant PosterPainter oldDelegate) {
    return !identical(coverImage, oldDelegate.coverImage) ||
        !identical(translatedLyrics, oldDelegate.translatedLyrics) ||
        !(backgroundConfig == oldDelegate.backgroundConfig);
  }
}
