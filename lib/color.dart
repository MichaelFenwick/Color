/**
 * Copyright (c) 2014 Michael Fenwick <mike@mikefenwick.com>
 *
 * The use of this source code is governed by the MIT license as specified
 * in the LICENSE file.
 */

library color;

import 'package:color/rgb_color.dart';

import 'hsl_color.dart';

abstract class CssColor<O> {
  String asCss(O displayOption);
}

abstract class Color {
  const Color();

  const factory Color.hex(int value) = RgbColor;

  const factory Color.rgb({int red, int green, int blue}) = RgbColor.fromRgba;

  const factory Color.rgba({int red, int green, int blue, int alpha}) =
      RgbColor.fromRgba;

  const factory Color.rgbo({int red, int green, int blue, num opacity}) =
      RgbColor.fromRgbo;

  const factory Color.hsl({num hue, num saturation, num lightness}) =
      HslColor.fromHslo;

  const factory Color.hslo(
      {num hue,
      num saturation,
      num lightness,
      num opacity}) = HslColor.fromHslo;

  const factory Color.hsla(
      {num hue, num saturation, num lightness, int alpha}) = HslColor.fromHsla;

  Color.parse(String value) {
    // TODO
  }

  // -----
  // Conversion
  // -----

  HslColor toHsl();

  RgbColor toRgb();

  String asCss();

  // -----
  // Manipulation
  // -----


  Color withAlpha(int alpha);

  Color withOpacity(int opacity);

  Color lighten(num steps);

  Color darken(num steps);
}
