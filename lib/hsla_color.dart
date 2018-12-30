part of color;

class HslaColor extends HslColor {
  final double opacity;

  static const minOpacity = 0.0;

  static const maxOpacity = 1.0;

  /**
   * Creates a [HslaColor] using a vector describing its hue, saturation,
   * luminance and opacity.
   *
   * The [hue] is given as a number in degrees, typically ranging in value
   * between 0 and 360.  Values outside of this converted as `hue % 360` to
   * be fit into the standard angle range.
   *
   * The [saturation] is given as a percentage between 0 and 100 (inclusive).
   *
   * The [luminance] is given as a percentage between 0 and 100 (inclusive).
   *
   * The [opacity] is given as a decimal number between 0 and 1 (inclusive).
   */
  const HslaColor(num h, num s, num l, [this.opacity = maxOpacity])
      : super(h, s, l);

  @override
  HslaColor toHslaColor() => this;

  @override
  RgbaColor toRgbaColor() => toRgbColor().withOpacity(opacity);

  @override
  OpacityCapableColor withOpacity(double a) => HslaColor(h, s, l, a);

  String toString() => 'hsla($h, $s%, $l%, $opacity)';

  Map<String, num> toMap() => {'h': h, 's': s, 'l': l, 'opacity': opacity};
}
