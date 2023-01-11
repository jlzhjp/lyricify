double _scale = 1;

void useScale(double scale) {
  _scale = scale;
}

extension IntExtension on int {
  int get sc => (this * _scale).toInt();
}

extension DoubleExtension on double {
  double get sc => this * _scale;
}
