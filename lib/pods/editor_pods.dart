import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pods/states/background_config_state.dart';
part 'editor_pods.g.dart';

enum EditorTab {
  layout(icon: Icons.layers, description: '排版'),
  text(icon: Icons.text_format, description: "文本"),
  background(icon: Icons.image, description: "背景"),
  decorations(icon: Icons.border_all, description: '装饰');

  final IconData icon;
  final String description;
  const EditorTab({required this.icon, required this.description});
}

@riverpod
class BackgroundConfig extends _$BackgroundConfig {
  @override
  BackgroundConfigState build() {
    return const BackgroundConfigState(
        type: BackgroundType.none,
        backgroundColor: Colors.white,
        lightness: 1,
        sigma: 0);
  }

  void update(
      BackgroundConfigState Function(BackgroundConfigState oldState) updater) {
    state = updater(state);
  }
}
