final regex = RegExp('id=(?<id>\\d+)');

int? tryGetIdfromInput(String input) {
  final match = regex.firstMatch(input);
  if (match == null) {
    return null;
  }

  return int.parse(match.namedGroup('id')!);
}
