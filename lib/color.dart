/**
* Copyright (c) 2014 Michael Fenwick <mike@mikefenwick.com>
*
* The use of this source code is governed by the MIT license as specified
* in the LICENSE file.
*/

library color;

import 'dart:math';

part 'rgb_color.dart';
part 'hex_color.dart';
part 'hsl_color.dart';
part 'xyz_color.dart';
part 'cielab_color.dart';

/**
 * An object representing a color.
 *
 * A [Color] can be constructed be specifying its value as either an RGB
 * vector, a 6 digit hex string, or an HSL vector, using the appropriate
 * named constructor.  Alternatively, the appropriate subclass can be
 * instantiated directly.
 **
 * [Color]s can be directly compared using the `==` operator, which
 * will return true if the two [Color] objects represent the same RGB color.
 * Because RGB values are bound to integers, colors in non-RGB color spaces
 * may have similar, but different, internal values and will still be
 * considered equivalent.
 */
abstract class Color {

  Color() {}
  factory Color.rgb(int r, int g, int b) => new RgbColor(r, g, b);
  factory Color.hex(String hexCode) => new HexColor(hexCode);
  factory Color.hsl(num h, num s, num l) => new HslColor(h, s, l);
  factory Color.xyz(num x, num y, num z) => new XyzColor(x, y, z);
  factory Color.cielab(num l, num a, num b) => new CielabColor(l, a, b);

  String toString();
  RgbColor toRgbColor();
  Map<String, num> toMap();

  get hashCode {
    RgbColor rgb = this.toRgbColor();
    return 256 * 256 * rgb.r + 256 * rgb.g + rgb.b;
  }

  operator ==(Object other) {
    return other is Color && this.hashCode == other.hashCode;
  }

  operator [](String key) {
    return this.toMap()[key];
  }
}
