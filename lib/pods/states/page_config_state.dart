import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_config_state.freezed.dart';

@freezed
class PageConfigState with _$PageConfigState {
  const factory PageConfigState({
    required int width,
  }) = _PageConfigState;
}
