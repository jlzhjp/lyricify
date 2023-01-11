import 'package:flutter/material.dart';
import 'states/font_config_state.dart';
import 'states/page_config_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pods/states/background_config_state.dart';
part 'editor_pods.g.dart';

typedef Updater<T> = T Function(T prev);

@riverpod
class PageConfig extends _$PageConfig {
  @override
  PageConfigState build() {
    return const PageConfigState(width: 1080);
  }

  void update(Updater<PageConfigState> updater) {
    state = updater(state);
  }
}

@riverpod
class BackgroundConfig extends _$BackgroundConfig {
  @override
  BackgroundConfigState build() {
    return const BackgroundConfigState(
        showBackground: false,
        backgroundColor: Colors.white,
        imageOpacity: 0,
        imageBlurSigma: 0);
  }

  void update(Updater<BackgroundConfigState> updater) {
    state = updater(state);
  }
}

@riverpod
class FontConfig extends _$FontConfig {
  @override
  FontConfigState build() {
    return const FontConfigState(
        autoGenerate: true,
        lyricFontSize: 18,
        translationFontSize: 14,
        lyricColor: Colors.black,
        translationColor: Colors.black45);
  }

  void update(Updater<FontConfigState> updater) {
    state = updater(state);
  }
}

@riverpod
double posterHeight(PosterHeightRef ref, double width) {
  // TODO
  throw UnimplementedError();
}
