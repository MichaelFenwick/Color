import 'package:meta/meta.dart';
import 'dart:math';

import 'color.dart';
import 'hsl_color.dart';

class RgbColor extends Color {
  static const maxAlpha = 255;
  static const maxOpacity = 1;

  final int value;

  num get opacity => alpha / maxAlpha;

  int get alpha => value & 0xFF000000 >> 24;

  int get red => value & 0xFF0000 >> 16;

  int get green => value & 0x00FF00 >> 8;

  int get blue => value & 0x0000FF >> 0;

  // -----
  // Constructors
  // -----

  const RgbColor(int value)
      : assert(value != null),
        value = value & 0xFFFFFFFF;

  const RgbColor.fromRgba(
      {@required int red, @required int green, @required int blue, int alpha})
      : assert(red != null),
        assert(green != null),
        assert(blue != null),
        value = ((alpha ?? maxAlpha & 0xff) << 24) |
            ((red & 0xff) << 16) |
            ((green & 0xff) << 8) |
            ((blue & 0xff) << 0) & 0xFFFFFF;

  const RgbColor.fromRgbo(
      {@required int red, @required int green, @required int blue, num opacity})
      : assert(red != null),
        assert(green != null),
        assert(blue != null),
        value = (((maxAlpha ~/ (1 / (opacity ?? maxOpacity))) & 0xff) << 24) |
            ((red & 0xff) << 16) |
            ((green & 0xff) << 8) |
            ((blue & 0xff) << 0) & 0xFFFFFF;

  // -----
  // Manipulation
  // -----

  RgbColor withAlpha(int alpha) => opacity != null
      ? RgbColor.fromRgba(red: red, green: green, blue: blue, alpha: alpha)
      : this;

  RgbColor withOpacity(num opacity) => opacity != null
      ? RgbColor.fromRgbo(red: red, green: green, blue: blue, opacity: opacity)
      : this;

  @override
  Color lighten(num steps) => toHsl().lighten(steps);

  @override
  Color darken(num steps) => toHsl().darken(steps);

  // -----
  // Conversion
  // -----

  // TODO: Cleanup.
  /// Using https://en.wikipedia.org/wiki/HSL_and_HSV#RGB_to_HSL_and_HSV
  @override
  HslColor toHsl() {
    num rf = red / 255;
    num gf = green / 255;
    num bf = blue / 255;
    num cMax = [rf, gf, bf].reduce(max);
    num cMin = [rf, gf, bf].reduce(min);
    num delta = cMax - cMin;
    num hue;
    num saturation;
    num lightness;

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

    lightness = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (lightness * 2 - 1).abs());
    }

    return HslColor.fromHsla(
        hue: hue,
        saturation: saturation * 100,
        lightness: lightness * 100,
        alpha: alpha);
  }

  @override
  RgbColor toRgb() => this;

  @override
  String asCss() => alpha == maxAlpha
      ? 'rgb($red, $green, $blue)'
      : 'rgba($red, $green, $blue, $opacity)';
}
