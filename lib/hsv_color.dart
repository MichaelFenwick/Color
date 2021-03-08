part of color;

class HsvColor extends Color {
  final num h;
  final num s;
  final num v;
  static const num hMin = 0;
  static const num sMin = 0;
  static const num vMin = 0;
  static const num hMax = 360;
  static const num sMax = 100;
  static const num vMax = 100;

  /// Creates a [HsvColor] using a vector describing its hue, saturation, and
  /// value.
  ///
  /// The [hue] is given as a number in degrees, typically ranging in value
  /// between 0 and 360.  Values outside of this converted as `hue % 360` to
  /// be fit into the standard angle range.
  ///
  /// The [saturation] is given as a percentage between 0 and 100 (inclusive).
  ///
  /// The [value] is given as a percentage between 0 and 100 (inclusive).
  const HsvColor(this.h, this.s, this.v);

  num abs(num value) => value >= 0 ? value : -value;

  @override
  RgbColor toRgbColor() => toHslColor().toRgbColor();

  @override
  HslColor toHslColor() {
    num hsvSaturation = s / 100;
    num value = v / 100;

    var lightness = value * (1 - hsvSaturation / 2);
    var saturation = lightness == 0 || lightness == 1 ? 0 : (value - lightness) / min(lightness, 1 - lightness);

    return HslColor(h, saturation * 100, lightness * 100);
  }

  @override
  HsvColor toHsvColor() => this;

  @override
  XyzColor toXyzColor() => toRgbColor().toXyzColor();

  @override
  CielabColor toCielabColor() => toRgbColor().toXyzColor().toCielabColor();

  @override
  String toString() => 'h: $h, s: $s%, v: $v%';

  @override
  Map<String, num> toMap() => {'h': h, 's': s, 'v': v};
}
