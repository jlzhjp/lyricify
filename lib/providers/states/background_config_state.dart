import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'background_config_state.freezed.dart';

enum BackgroundType {
  none(icon: Icons.broken_image, description: "无"),
  color(icon: Icons.colorize, description: "颜色"),
  image(icon: Icons.image, description: "图片");

  final IconData icon;
  final String description;
  const BackgroundType({required this.icon, required this.description});
}

@freezed
class BackgroundConfigState with _$BackgroundConfigState {
  const factory BackgroundConfigState({
    required BackgroundType type,
    required Color backgroundColor,
    required double lightness,
    required double sigma,
  }) = _BackgroundConigState;
}
