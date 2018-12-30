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

part 'xyz_color.dart';

part 'cielab_color.dart';

part 'color_filter.dart';

part 'color_parser.dart';

/**
 * An object representing a color.
 *
 * A [Color] can be constructed be specifying its value as either an RGB vector, a 6 digit hex string, an HSL vector, an XYZ vector, or a LAB vector using the appropriate named constructor. Alternatively, the appropriate subclass can be instantiated directly.
 *
 * [Color]s can be directly compared using the `==` operator, which will return true if the two [Color] objects represent the same RGB color.
 */
abstract class Color {
  const Color();

  const factory Color.rgb(int r, int g, int b) = RgbColor;

  const factory Color.rgba(int r, int g, int b, double opacity) = RgbaColor;

  factory Color.hex(String hexCode) = HexColor;

  const factory Color.hsl(num h, num s, num l) = HslColor;

  const factory Color.xyz(num x, num y, num z) = XyzColor;

  const factory Color.cielab(num l, num a, num b) = CielabColor;

  RgbColor toRgbColor();

  // TODO: Write tests.
  RgbaColor toRgbaColor();

  HexColor toHexColor() => toRgbColor().toHexColor();

  HslColor toHslColor();

  XyzColor toXyzColor();

  CielabColor toCielabColor();

  String toString();

  Map<String, num> toMap();

  get hashCode {
    RgbColor rgb = this.toRgbColor();
    return 256 * 256 * rgb.r.toInt() + 256 * rgb.g.toInt() + rgb.b.toInt();
  }

  operator ==(Object other) => other is Color && this.hashCode == other.hashCode;

  operator [](String key) => this.toMap()[key];

  Color _convert(Type colorType) {
    if (colorType is RgbColor) {
      return this.toRgbColor();
    } else if (colorType is HexColor) {
      return this.toHexColor();
    } else if (colorType is HslColor) {
      return this.toHslColor();
    } else if (colorType is XyzColor) {
      return this.toXyzColor();
    } else if (colorType is CielabColor) {
      return this.toCielabColor();
    } else {
      return this;
    }
  }
}

abstract class OpacityCapableColor extends Color {
  const OpacityCapableColor();

  OpacityCapableColor withOpacity(double a);

  HslaColor toHslaColor();

  get hashCode {
    RgbaColor rgba = this.toRgbaColor();
    return (pow(2, 30) * rgba._opacity).round() +
        256 * 256 * rgba.r +
        256 * rgba.g +
        rgba.b;
  }
}


