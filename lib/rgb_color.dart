part of color;

class RgbColor extends Color {

  int _r;
  int _g;
  int _b;

  /**
   * Creates a [Color] using a vector describing its red, green, and blue
   * values.
   *
   * The value for [r], [g], and [b] should be in the range between 0 and
   * 255 (inclusive).  Values above this range will be assumed to be a value
   * of 255, and values below this range will be assumed to be a value of 0.
   */
  RgbColor(int r, int g, int b) {
    _r = r;
    _g = g;
    _b = b;
  }

  get r => _r;
  get g => _g;
  get b => _b;

  set r(int r) => _r = max(0, min(255, r));
  set g(int g) => _g = max(0, min(255, g));
  set b(int b) => _b = max(0, min(255, b));

  HslColor toHslColor() {
    num rf = _r / 255;
    num gf = _g / 255;
    num bf = _b / 255;
    num cMax = [rf, gf, bf].reduce(max);
    num cMin = [rf, gf, bf].reduce(min);
    num delta = cMax - cMin;
    num hue;
    num saturation;
    num luminance;

    if (cMax == rf) {
      hue = 60 * ((gf - bf) / delta % 6);
    } else if (cMax == gf) {
      hue = 60 * ((bf - rf) / delta + 2);
    } else {
      hue = 60 * ((rf - gf) / delta + 4);
    }

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    return new HslColor(hue, saturation * 100, luminance * 100);
  }

  HexColor toHexColor() => new HexColor.fromRgb(_r, _g, _b);

  RgbColor toRgbColor() => this;

  String toString() => "r: $r, g: $g, b: $b";

}
