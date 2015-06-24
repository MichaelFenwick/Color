part of color;

class RgbColor extends Color {
  final num r;
  final num g;
  final num b;
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
  const RgbColor(num this.r, num this.g, num this.b);

  RgbColor toRgbColor() => this;

  HslColor toHslColor() {
    num rf = r / 255;
    num gf = g / 255;
    num bf = b / 255;
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
    Map<String, num> rgb = {'r': r / 255, 'g': g / 255, 'b': b / 255};

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

  HexColor toHexColor() => new HexColor.fromRgb(r, g, b);

  String toString() => "r: $r, g: $g, b: $b";

  String toCssString() => 'rgb(${r.toInt()}, ${g.toInt()}, ${b.toInt()})';

  Map<String, num> toMap() => {'r': r, 'g': g, 'b': b};
}
