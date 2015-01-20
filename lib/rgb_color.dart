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
  RgbColor(num r, num g, num b) {
    _r = r.toInt();
    _g = g.toInt();
    _b = b.toInt();
  }

  get r => _r;
  get g => _g;
  get b => _b;

  set r(int r) => _r = max(0, min(255, r.toInt()));
  set g(int g) => _g = max(0, min(255, g.toInt()));
  set b(int b) => _b = max(0, min(255, b.toInt()));

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

  XyzColor toXyzColor() {
    Map<String, num> rgb = {
      'r': _r / 255,
      'g': _g / 255,
      'b': _b / 255
    };

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

  RgbColor toRgbColor() => this;

  Map<String, int> toMap() {
    return {
      'r': r,
      'g': g,
      'b': b
    };
  }

  String toString() => "r: $r, g: $g, b: $b";

}
