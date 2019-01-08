part of color;

class HslaColor extends HslColor {
  static const minOpacity = 0;
  static const maxOpacity = 1;

  /// Decimal number between 0 and 1 (inclusive) representing the [opacity]
  /// of a color.
  /// Gets clipped to a number between 0 and 1 (inclusive) when used in
  /// calculations.
  final num opacity;

  /// Creates a [HslaColor] using a vector describing its [hue], [saturation],
  /// [lightness] and [opacity] (optional, defaults to [maxOpacity]).
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
  const HslaColor(num h, num s, num l, [this.opacity = maxOpacity])
      : super(h, s, l);

  // -----
  // Converters
  // -----

  @override
  HslaColor toHslaColor() => this;

  @override
  RgbaColor toRgbaColor() => toRgbColor().withOpacity(opacity);

  @override
  Color withOpacity(double a) => HslaColor(hue, saturation, lightness, a);

  // -----
  // Other
  // -----

  String toString() => 'hsla($hue, $saturation%, $lightness%, $opacity)';

  Map<String, num> toMap() =>
      {'h': hue, 's': saturation, 'l': lightness, 'opacity': opacity};
}
