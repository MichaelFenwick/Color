part of color;

class RgbaColor extends RgbColor {
  final double _opacity;

  double get opacity => double.parse(_opacity.toStringAsFixed(2));

  static const minOpacity = 0.0;

  static const maxOpacity = 1.0;

  static const minAlpha = 0;

  static const maxAlpha = 255;

  /// Creates a [Color] using a vector describing its red, green, blue
  /// and alpha values.
  ///
  /// The value for [r], [g] and [b] should be in the range between 0 and
  /// 255 (inclusive).  Values above this range will be assumed to be a value
  /// of 255, and values below this range will be assumed to be a value of 0.
  /// The value for [alpha] is optional (defaults to opaque)
  /// but should be in the range between 0 and 1.
  /// Values above this range will be assumed to be a value of 1, and values
  /// below this range will be assumed to be a value of 0.
  const RgbaColor(int r, int g, int b, [this._opacity = maxOpacity])
      : super(r, g, b);

  String toString() =>
      'rgba(${r.toInt()}, ${g.toInt()}, ${b.toInt()}, ${_opacity})';

  @override
  HslaColor toHslaColor() => toHslColor().withOpacity(_opacity);

  @override
  RgbaColor toRgbaColor() => this;

  static double alphaToOpacity(int alpha) => alpha / maxAlpha;
}
