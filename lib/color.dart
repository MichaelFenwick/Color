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
 */
abstract class Color {

  Color() {}
  factory Color.rgb(int r, int g, int b) => new RgbColor(r, g, b);
  factory Color.hex(String hexCode) => new HexColor(hexCode);
  factory Color.hsl(num h, num s, num l) => new HslColor(h, s, l);

  String toString();
  RgbColor toRgbColor();

  get hashCode {
    RgbColor rgb = this.toRgbColor();
    print (256 * 256 * rgb.r + 256 * rgb.g + rgb.b);
    return 256 * 256 * rgb.r + 256 * rgb.g + rgb.b;
  }

  operator ==(Object other) {
    return other is Color && this.hashCode == other.hashCode;
  }
}