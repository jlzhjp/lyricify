final regex = RegExp('id=(?<id>\\d+)');

/// 尝试从用户的输入中获取歌曲的 ID
int? tryGetIdFromInput(String input) {
  final match = regex.firstMatch(input);
  if (match == null) {
    return null;
  }

  return int.parse(match.namedGroup('id')!);
}
