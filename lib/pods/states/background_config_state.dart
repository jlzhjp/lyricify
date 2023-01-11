import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'background_config_state.freezed.dart';

@freezed
class BackgroundConfigState with _$BackgroundConfigState {
  const factory BackgroundConfigState({
    required bool showBackground,
    required Color backgroundColor,
    required double imageOpacity,
    required double imageBlurSigma,
  }) = _BackgroundConfigState;
}
