part of color;

class RgbColor extends Color {
  int _r;
  int _g;
  int _b;
  static const int rMin = 0;
  static const int gMin = 0;
  static const int bMin = 0;
  static const int rMax = 255;
  static const int gMax = 255;
  static const int bMax = 255;

  /**
   * Creates a [Color] using a vector describing its red, green, and blue
   * values.
   *
   * The value for [r], [g], and [b] should be in the range between 0 and
   * 255 (inclusive).  Values above this range will be assumed to be a value
   * of 255, and values below this range will be assumed to be a value of 0.
   */
  RgbColor(num r, num g, num b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  get r => _r;
  get g => _g;
  get b => _b;

  set r(num r) => _r = max(bMin, min(rMax, r)).toInt();
  set g(num g) => _g = max(bMin, min(gMax, g)).toInt();
  set b(num b) => _b = max(bMin, min(bMax, b)).toInt();

  RgbColor toRgbColor() => this;

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

    if (hue.isNaN || hue.isInfinite) {
      hue = 0;
    }

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    return new HslColor(hue, saturation * 100, luminance * 100);
  }

  XyzColor toXyzColor() {
    Map<String, num> rgb = {'r': _r / 255, 'g': _g / 255, 'b': _b / 255};

    rgb.forEach((key, value) {
      if (value > 0.04045) {
        rgb[key] = pow((value + 0.055) / 1.055, 2.4);
      } else {
        rgb[key] = value / 12.92;
      }
      rgb[key] *= 100;
    });

    num x = rgb['r'] * 0.4124 + rgb['g'] * 0.3576 + rgb['b'] * 0.1805;
    num y = rgb['r'] * 0.2126 + rgb['g'] * 0.7152 + rgb['b'] * 0.0722;
    num z = rgb['r'] * 0.0193 + rgb['g'] * 0.1192 + rgb['b'] * 0.9505;

    return new XyzColor(x, y, z);
  }

  CielabColor toCielabColor() => this.toXyzColor().toCielabColor();

  HexColor toHexColor() => new HexColor.fromRgb(_r, _g, _b);

  String toString() => "r: $r, g: $g, b: $b";

  String toCssString() => 'rgb($r, $g, $b)';

  Map<String, int> toMap() {
    return {'r': r, 'g': g, 'b': b};
  }

  RgbColor clone() => new RgbColor(this.r, this.g, this.b);
}
