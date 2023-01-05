import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredImageBackground extends StatefulWidget {
  final Widget image;
  const BlurredImageBackground({super.key, required this.image});

  @override
  State<BlurredImageBackground> createState() => _BlurredImageBackgroundState();
}

class _BlurredImageBackgroundState extends State<BlurredImageBackground> {
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: widget.image,
      ),
    );
  }
}
