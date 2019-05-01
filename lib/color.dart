/**
 * Copyright (c) 2014 Michael Fenwick <mike@mikefenwick.com>
 *
 * The use of this source code is governed by the MIT license as specified
 * in the LICENSE file.
 */

library color;

import 'dart:math';

part 'rgb_color.dart';

part 'rgba_color.dart';

part 'hex_color.dart';

part 'hsl_color.dart';

part 'hsla_color.dart';

part 'color_parser.dart';

abstract class Color {
  const Color();

  const factory Color.rgb(int red, int green, int blue) = RgbColor.fromRgb;

  const factory Color.rgba(int red, int green, int blue, int alpha) =
      RgbaColor.fromRgba;

  const factory Color.hsl(num hue, num saturation, num lightness) = HslColor;

  const factory Color.hsla(num hue, num saturation, num lightness, num alpha) =
      HslaColor;

  Color.parse(String color) {
    // TODO
  }

// -----
// Converters
// -----

  Color toRgbColor();

  Color toRgbaColor();

  Color toHexColor() => toRgbaColor().toHexColor();

  Color toHslColor();

  Color toHslaColor();

  Color withAlpha(int alpha);

  // -----
  // Other
  // -----

  String toString();

  get hashCode {
    RgbaColor rgba = this.toRgbaColor();
    return (pow(2, 30) * rgba._opacity).round() +
        256 * 256 * rgba.r +
        256 * rgba.g +
        rgba.b;
  }

  operator ==(Object other) =>
      other is Color && this.hashCode == other.hashCode;

  Color _convert(Type colorType) {
    if (colorType is RgbColor) {
      return this.toRgbColor();
    } else if (colorType is HexColor) {
      return this.toHexColor();
    } else if (colorType is HslColor) {
      return this.toHslColor();
    } else {
      return this;
    }
  }
}
