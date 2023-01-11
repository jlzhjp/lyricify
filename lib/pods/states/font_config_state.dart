import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'font_config_state.freezed.dart';

@freezed
class FontConfigState with _$FontConfigState {
  const factory FontConfigState({
    required bool autoGenerate,
    required double lyricFontSize,
    required double translationFontSize,
    required Color lyricColor,
    required Color translationColor,
  }) = _FontConfigState;
}
