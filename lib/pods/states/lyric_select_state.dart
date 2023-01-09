import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/lyrics.dart';

part 'lyric_select_state.freezed.dart';

@freezed
class LyricSelectState with _$LyricSelectState {
  const factory LyricSelectState({
    required TranslatedLyric lyric,
    required bool selected,
  }) = _LyricSelectState;
}
