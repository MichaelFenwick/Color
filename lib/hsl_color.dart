import 'dart:math';

import 'package:color/rgb_color.dart';
import 'package:meta/meta.dart';

import 'color.dart';

class HslColor extends Color {
  static const minHue = 0;
  static const minSaturation = 0;
  static const minLightness = 0;
  static const minOpacity = 0;

  static const maxHue = 360;
  static const maxSaturation = 100;
  static const maxLightness = 100;
  static const maxOpacity = 1;
  static const maxAlpha = 255;

  @override
  final num opacity;

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

  // -----
  // Constructors
  // -----

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
  const HslColor.fromHslo(
      {@required num hue,
      @required num saturation,
      @required num lightness,
      num opacity})
      : assert(hue != null),
        assert(saturation != null),
        assert(lightness != null),
        this.hue = hue % maxHue,
        this.saturation = saturation % maxSaturation,
        this.lightness = lightness % maxLightness,
        this.opacity = (opacity ?? maxOpacity) % maxOpacity;

  const HslColor.fromHsla(
      {@required num hue,
      @required num saturation,
      @required num lightness,
      int alpha})
      : assert(hue != null),
        assert(saturation != null),
        assert(lightness != null),
        this.hue = hue % maxHue,
        this.saturation = saturation % maxSaturation,
        this.lightness = lightness % maxLightness,
        this.opacity = ((alpha ?? maxAlpha) % maxAlpha) / maxAlpha;

  // -----
  // Manipulation
  // -----

  @override
  Color withAlpha(int alpha) => alpha != null
      ? HslColor.fromHsla(
          hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
      : this;

  @override
  Color withOpacity(int opacity) => opacity != null
      ? HslColor.fromHslo(
          hue: hue,
          saturation: saturation,
          lightness: lightness,
          opacity: opacity)
      : this;

  @override
  Color lighten(num steps) =>
      steps != null ? _copy(lightness: this.lightness + steps) : this;

  @override
  Color darken(num steps) =>
      steps != null ? _copy(lightness: this.lightness - steps) : this;

  // -----
  // Conversion
  // -----

  @override
  HslColor toHsl() => this;

  /// Using https://en.wikipedia.org/wiki/HSL_and_HSV#Alternative_HSL_to_RGB
  @override
  RgbColor toRgb() {
    int f(int n) {
      final a = saturation * min(lightness, 1 - lightness);
      final k = (n + hue / 30) % 12;
      return lightness - a * max(min(min(k - 3, 9 - k), 1), -1);
    }

    return RgbColor.fromRgbo(
        red: f(0), green: f(8), blue: f(4), opacity: opacity);
  }

  // -----
  // Util
  // -----

  HslColor _copy({num hue, num saturation, num lightness, num opacity}) =>
      HslColor.fromHslo(
          hue: hue ?? this.hue,
          saturation: saturation ?? this.saturation,
          lightness: lightness ?? this.lightness,
          opacity: opacity ?? this.opacity);
}
