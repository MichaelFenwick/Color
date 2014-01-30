/**
* Copyright (c) 2014 Michael Fenwick <mike@mikefenwick.com>
*
* The use of this source code is governed by the MIT license as specified
* in the LICENSE file.
*/

library color;

import 'dart:math';

/**
* An object representing a color in the RGB color space.
*
* A [Color] can be constructed be specifying its value as either an RGB
* vector, a 6 digit hex string, or an HSL vector, using the appropriate
* named constructor.  For example, the following constructions are all
* identical:
*
*     new Color.rgb(192, 255, 238);
*     new Color.hex('c0ffee');
*     new Color.hsl(163.8, 100, 87.6);
*
* Each of the above constructors will result in a Color object that has
* internal RGB values of 192, 255, 238.
*
* [Color]s can also be directly compared using the `==` operator, which
* will return true if the two [Color] objects represent the same RGB color.
*/
class Color {
  int _r;
  int _g;
  int _b;

  Color() {}

  /**
  * Creates a [Color] using a vector describing its red, green, and blue
  * values.
  *
  * The value for [r], [g], and [b] should be in the range between 0 and
  * 255 (inclusive).  Values above this range will be assumed to be a value
  * of 255, and values below this range will be assumed to be a value of 0.
  */
  Color.rgb(int r, int g, int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  /**
  * Creates a [Color] using a [String] describing its RGB value in hex.
  *
  * The [hexCode] should be a string of 6 characters, each of which is a
  * valid hex character (0 through 9 and A through F).  Capital and lowercase
  * letters will work equally well.  Characters after the first 6 characters
  * will be ignored.  If non-valid hex characters are encountered, a
  * [FormatException] will be thrown.
  *
  * The [hexCode] should not be preceeded with a pound sign (#).
  */
  Color.hex(String hexCode) {
    Map<String, int> rgb = hexToRgb(hexCode);
    this.r = rgb['r'];
    this.g = rgb['g'];
    this.b = rgb['b'];
  }

  /**
  * Creates a [Color] using a vector describing its hue, saturation, and
  * luminance.
  *
  * The [hue] is given as a number in degrees, typically ranging in value
  * between 0 and 360.  Values outside of this converted as `hue % 360` to
  * be fit into the standard angle range.
  *
  * The [saturation] is given as a percentage between 0 and 100 (inclusive).
  *
  * The [luminance] is given as a percentage between 0 and 100 (inclusive).
  */
  Color.hsl(num hue, num saturation, num luminance) {
    Map<String, int> rgb = hslToRgb(hue, saturation, luminance);
    this.r = rgb['r'];
    this.g = rgb['g'];
    this.b = rgb['b'];
  }

  get r => _r;
  get g => _g;
  get b => _b;

  set r(int r) => _r = max(0, min(255, r));
  set g(int g) => _g = max(0, min(255, g));
  set b(int b) => _b = max(0, min(255, b));

  get hashCode => 256 * 256 * r + 256 * g + b;
  operator ==(Color o) => r == o.r && g == o.g && b == o.b;

  String toString() => "r: $r, g: $g, b: $b";
  String toHexString() => rgbToHexString(r, g, b);
  String toHslString() {
    Map <String, num> hsl = rgbToHsl(r, g, b);
    return "h: ${hsl['h'].round()}, s: ${hsl['s'].toStringAsFixed(1)}%, l: ${hsl['l'].toStringAsFixed(1)}%";
  }

  static String rgbToHexString(int r, int g, int b) {
    Map <String, String> hex = rgbToHex(r, g, b);
    return "${hex['r']}${hex['g']}${hex['b']}";
  }

  static Map<String, String> rgbToHex(int r, int g, int b) {
    return {
        'r': r.toRadixString(16),
        'g': g.toRadixString(16),
        'b': b.toRadixString(16)
    };
  }


  static Map<String, num> rgbToHsl(int r, int g, int b) {
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

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    return {
        'h': hue,
        's': saturation * 100,
        'l': luminance * 100
    };
  }

  static Map<String, int> hexToRgb(String hexCode) {
    List<String> hexDigits = hexCode.split('');
    return {
      'r': int.parse(hexDigits.sublist(0, 2).join(), radix: 16),
      'g': int.parse(hexDigits.sublist(2, 4).join(), radix: 16),
      'b': int.parse(hexDigits.sublist(4).join(), radix: 16)
    };
  }

  static Map<String, num> hexToHsl(String hexCode) {
    Map<String, int> rgb = hexToRgb(hexCode);
    return rgbToHsl(rgb['r'], rgb['g'], rgb['b']);
  }

  static Map<String, int> hslToRgb(num hue, num saturation, num luminance) {
    List<num> rgb = [0, 0, 0];

    hue = hue / 360 % 1;
    saturation /= 100;
    luminance /= 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val));

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val);
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1);
    }

    rgb = rgb.map((val) => (val * 255).round());

    rgb = rgb.toList();

    return {
      'r': rgb[0],
      'g': rgb[1],
      'b': rgb[2],
    };
  }

  static Map<String, String> hslToHex(num hue, num saturation, num luminance) {
    Map<String, int> rgb = hslToRgb(hue, saturation, luminance);
    return rgbToHex(rgb['r'], rgb['g'], rgb['b']);
  }

}