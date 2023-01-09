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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final maskColor = isDarkMode ? Colors.black : Colors.white;
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: widget.image,
          ),
        ),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(color: maskColor.withOpacity(0.85)),
        ))
      ],
    );
  }
}
