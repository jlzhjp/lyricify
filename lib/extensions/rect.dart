import 'dart:ui';

extension Size2RectExtensions on Size {
  Rect get rectFromOrigin {
    return Rect.fromLTWH(0, 0, width, height);
  }
}

extension Image2RectExtension on Image {
  Rect get fullRect {
    return Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble());
  }
}
