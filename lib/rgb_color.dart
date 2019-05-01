part of color;

class RgbColor extends Color {
  final int value;

  int get red => value & 0xFF0000 >> 16;

  int get green => value & 0x00FF00 >> 8;

  int get blue => value & 0x0000FF >> 0;

  const RgbColor(int value) : value = value & 0xFFFFFF;

  const RgbColor.fromRgb(int red, int green, int blue)
      : value = ((red & 0xff) << 16) |
  ((green & 0xff) << 8) |
  ((blue & 0xff) << 0) & 0xFFFFFF;

  // TODO: Cleanup.
  Color toHslColor() {
    num rf = red / 255;
    num gf = green / 255;
    num bf = blue / 255;
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

    return HslColor(hue, saturation * 100, luminance * 100);
  }

  @override
  Color toHslaColor() => toHslColor().toHslaColor();

  @override
  Color toRgbColor() => this;

  @override
  Color toRgbaColor() => RgbaColor(value);

  @override
  Color withAlpha(int alpha) => toRgbaColor().withAlpha(alpha);
}
