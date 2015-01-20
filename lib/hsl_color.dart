part of color;

class HslColor extends Color {

  num _h;
  num _s;
  num _l;

  /**
   * Creates a [HslColor] using a vector describing its hue, saturation, and
   * luminance.
   *
   * The [hue] is given as a number in degrees, typically ranging in value
   * between 0 and 360.  Values outside of this converted as `hue % 360` to
   * be fit into the standard angle range.
   *
   * The [saturation] is given as a percentage between 0 and 100 (inclusive).
   *
   * The [luminance] is given as a percentage between 0 and 100 (inclusive).
   */
  HslColor(num hue, num saturation, num luminance) {
    _h = hue % 360;
    _s = saturation;
    _l = luminance;
  }

  get h => _h % 360;
  get s => _s;
  get l => _l;

  set h(num h) => _h = h % 360;
  set s(num s) => _s = max(0, min(100, s));
  set l(num l) => _l = max(0, min(100, l));

  RgbColor toRgbColor() {
    List<num> rgb = [0, 0, 0];

    num hue = _h / 360 % 1;
    num saturation = _s / 100;
    num luminance = _l / 100;

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

  String toString() => "h: $h, s: $s%, l: $l%";

}
