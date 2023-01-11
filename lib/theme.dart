import 'dart:io';

import 'package:flutter/material.dart';

String? getFontFamily() {
  // 在 Windows 上使用 Noto Sans 字体
  if (Platform.isWindows) {
    return 'Noto Sans CJK SC';
  }
  return null;
}

ThemeData createThemeData(Brightness brightness) {
  return ThemeData(
      fontFamily: getFontFamily(),
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: brightness,
      ));
}

final lightTheme = createThemeData(Brightness.light);
final darkTheme = createThemeData(Brightness.dark);
