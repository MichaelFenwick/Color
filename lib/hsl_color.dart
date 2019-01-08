part of color;

class HslColor extends Color {
  static const hueMin = 0;
  static const saturationMin = 0;
  static const lightnessMin = 0;
  static const hueMax = 360;
  static const saturationMax = 100;
  static const lightnessMax = 100;

  /// Number in degrees representing the [hue] of a color typically ranging in
  /// value between 0 and 360 (inclusive).
  /// Values outside of this converted as `hue % 360` when used in calculations.
  /// E.g. -40 -> ||-40| - 360| = 320, 450 -> ||450| - 360| = 90
  final num hue;

  /// Percentage between 0 and 100 (inclusive) representing the [saturation] of a color.
  /// Gets clipped to a number between 0 and 100 (inclusive) when used in
  /// calculations.
  final num saturation;

  /// Percentage representing the [lightness] of a color.
  /// Gets clipped to a number between 0 and 100 (inclusive) when used in
  /// calculations.
  final num lightness;

  /// Creates a [HslColor] using a vector describing its [hue], [saturation]
  /// and [lightness].
  ///
  /// The [hue] is given as a number in degrees, typically ranging in value
  /// between 0 and 360. Values outside of this converted as `hue % 360` to
  /// be fit into the standard angle range.
  ///
  /// The [saturation] is given as a percentage between 0 and 100 (inclusive).
  /// Gets clipped to a number between 0 and 100 (inclusive).
  ///
  /// The [lightness] is given as a percentage between 0 and 100 (inclusive).
  /// Gets clipped to a number between 0 and 100 (inclusive).
  const HslColor(num this.hue, num this.saturation, num this.lightness);

  // -----
  // Converters
  // -----

  RgbColor toRgbColor() {
    List<num> rgb = [0, 0, 0];

    num hue = this.hue / 360 % 1;
    num saturation = this.saturation / 100;
    num luminance = this.lightness / 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val)).toList();

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val).toList();
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1).toList();
    }

    rgb = rgb.map((val) => (val * 255).round()).toList();

    return new RgbColor(rgb[0], rgb[1], rgb[2]);
  }

  @override
  HslColor toHslColor() => this;

  @override
  HslaColor toHslaColor() => HslaColor(hue, saturation, lightness);

  @override
  RgbaColor toRgbaColor() => toRgbColor().toRgbaColor();

  @override
  Color withOpacity(double a) => toHslaColor().withOpacity(a);

  // -----
  // Other
  // -----

  String toString() => 'hsl($hue, $saturation%, $lightness%)';

  Map<String, num> toMap() =>
      {'hue': hue, 'saturation': saturation, 'lightness': lightness};
}
