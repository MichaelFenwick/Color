part of color;

class RgbColor extends Color implements CssColorSpace {
  final num r;
  final num g;
  final num b;
  static const int rMin = 0;
  static const int gMin = 0;
  static const int bMin = 0;
  static const int rMax = 255;
  static const int gMax = 255;
  static const int bMax = 255;

  /// Creates a [Color] using a vector describing its red, green, and blue
  /// values.
  ///
  /// The value for [r], [g], and [b] should be in the range between 0 and
  /// 255 (inclusive).  Values above this range will be assumed to be a value
  /// of 255, and values below this range will be assumed to be a value of 0.
  const RgbColor(this.r, this.g, this.b);

  factory RgbColor.name(String name) {
    if (RgbColor.namedColors.containsKey(name)) {
      return RgbColor.namedColors[name];
    } else {
      throw ArgumentError(
          'Only the color names defined by the CSS3 spec are supported. See http://www.w3.org/TR/css3-color/#svg-color for a list of valid color names.');
    }
  }

  @override
  RgbColor toRgbColor() => this;

  @override
  HslColor toHslColor() {
    num rf = r / 255;
    num gf = g / 255;
    num bf = b / 255;
    var cMax = [rf, gf, bf].reduce(max);
    var cMin = [rf, gf, bf].reduce(min);
    var delta = cMax - cMin;
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
  HsvColor toHsvColor() => toHslColor().toHsvColor();

  @override
  XyzColor toXyzColor() {
    var rgb = <String, num>{'r': r / 255, 'g': g / 255, 'b': b / 255};

    rgb.forEach((key, value) {
      if (value > 0.04045) {
        rgb[key] = pow((value + 0.055) / 1.055, 2.4);
      } else {
        rgb[key] = value / 12.92;
      }
      rgb[key] *= 100;
    });

    var x = rgb['r'] * 0.4124 + rgb['g'] * 0.3576 + rgb['b'] * 0.1805;
    var y = rgb['r'] * 0.2126 + rgb['g'] * 0.7152 + rgb['b'] * 0.0722;
    var z = rgb['r'] * 0.0193 + rgb['g'] * 0.1192 + rgb['b'] * 0.9505;

    return XyzColor(x, y, z);
  }

  @override
  CielabColor toCielabColor() => toXyzColor().toCielabColor();

  @override
  HexColor toHexColor() => HexColor.fromRgb(r, g, b);

  @override
  String toString() => 'r: $r, g: $g, b: $b';

  @override
  String toCssString() => 'rgb(${r.toInt()}, ${g.toInt()}, ${b.toInt()})';

  @override
  Map<String, num> toMap() => {'r': r, 'g': g, 'b': b};

  static const Map<String, RgbColor> namedColors = {
    'aliceblue': Color.rgb(240, 248, 255) as RgbColor,
    'antiquewhite': Color.rgb(250, 235, 215) as RgbColor,
    'aqua': Color.rgb(0, 255, 255) as RgbColor,
    'aquamarine': Color.rgb(127, 255, 212) as RgbColor,
    'azure': Color.rgb(240, 255, 255) as RgbColor,
    'beige': Color.rgb(245, 245, 220) as RgbColor,
    'bisque': Color.rgb(255, 228, 196) as RgbColor,
    'black': Color.rgb(0, 0, 0) as RgbColor,
    'blanchedalmond': Color.rgb(255, 235, 205) as RgbColor,
    'blue': Color.rgb(0, 0, 255) as RgbColor,
    'blueviolet': Color.rgb(138, 43, 226) as RgbColor,
    'brown': Color.rgb(165, 42, 42) as RgbColor,
    'burlywood': Color.rgb(222, 184, 135) as RgbColor,
    'cadetblue': Color.rgb(95, 158, 160) as RgbColor,
    'chartreuse': Color.rgb(127, 255, 0) as RgbColor,
    'chocolate': Color.rgb(210, 105, 30) as RgbColor,
    'coral': Color.rgb(255, 127, 80) as RgbColor,
    'cornflowerblue': Color.rgb(100, 149, 237) as RgbColor,
    'cornsilk': Color.rgb(255, 248, 220) as RgbColor,
    'crimson': Color.rgb(220, 20, 60) as RgbColor,
    'cyan': Color.rgb(0, 255, 255) as RgbColor,
    'darkblue': Color.rgb(0, 0, 139) as RgbColor,
    'darkcyan': Color.rgb(0, 139, 139) as RgbColor,
    'darkgoldenrod': Color.rgb(184, 134, 11) as RgbColor,
    'darkgray': Color.rgb(169, 169, 169) as RgbColor,
    'darkgreen': Color.rgb(0, 100, 0) as RgbColor,
    'darkgrey': Color.rgb(169, 169, 169) as RgbColor,
    'darkkhaki': Color.rgb(189, 183, 107) as RgbColor,
    'darkmagenta': Color.rgb(139, 0, 139) as RgbColor,
    'darkolivegreen': Color.rgb(85, 107, 47) as RgbColor,
    'darkorange': Color.rgb(255, 140, 0) as RgbColor,
    'darkorchid': Color.rgb(153, 50, 204) as RgbColor,
    'darkred': Color.rgb(139, 0, 0) as RgbColor,
    'darksalmon': Color.rgb(233, 150, 122) as RgbColor,
    'darkseagreen': Color.rgb(143, 188, 143) as RgbColor,
    'darkslateblue': Color.rgb(72, 61, 139) as RgbColor,
    'darkslategray': Color.rgb(47, 79, 79) as RgbColor,
    'darkslategrey': Color.rgb(47, 79, 79) as RgbColor,
    'darkturquoise': Color.rgb(0, 206, 209) as RgbColor,
    'darkviolet': Color.rgb(148, 0, 211) as RgbColor,
    'deeppink': Color.rgb(255, 20, 147) as RgbColor,
    'deepskyblue': Color.rgb(0, 191, 255) as RgbColor,
    'dimgray': Color.rgb(105, 105, 105) as RgbColor,
    'dimgrey': Color.rgb(105, 105, 105) as RgbColor,
    'dodgerblue': Color.rgb(30, 144, 255) as RgbColor,
    'firebrick': Color.rgb(178, 34, 34) as RgbColor,
    'floralwhite': Color.rgb(255, 250, 240) as RgbColor,
    'forestgreen': Color.rgb(34, 139, 34) as RgbColor,
    'fuchsia': Color.rgb(255, 0, 255) as RgbColor,
    'gainsboro': Color.rgb(220, 220, 220) as RgbColor,
    'ghostwhite': Color.rgb(248, 248, 255) as RgbColor,
    'gold': Color.rgb(255, 215, 0) as RgbColor,
    'goldenrod': Color.rgb(218, 165, 32) as RgbColor,
    'gray': Color.rgb(128, 128, 128) as RgbColor,
    'green': Color.rgb(0, 128, 0) as RgbColor,
    'greenyellow': Color.rgb(173, 255, 47) as RgbColor,
    'grey': Color.rgb(128, 128, 128) as RgbColor,
    'honeydew': Color.rgb(240, 255, 240) as RgbColor,
    'hotpink': Color.rgb(255, 105, 180) as RgbColor,
    'indianred': Color.rgb(205, 92, 92) as RgbColor,
    'indigo': Color.rgb(75, 0, 130) as RgbColor,
    'ivory': Color.rgb(255, 255, 240) as RgbColor,
    'khaki': Color.rgb(240, 230, 140) as RgbColor,
    'lavender': Color.rgb(230, 230, 250) as RgbColor,
    'lavenderblush': Color.rgb(255, 240, 245) as RgbColor,
    'lawngreen': Color.rgb(124, 252, 0) as RgbColor,
    'lemonchiffon': Color.rgb(255, 250, 205) as RgbColor,
    'lightblue': Color.rgb(173, 216, 230) as RgbColor,
    'lightcoral': Color.rgb(240, 128, 128) as RgbColor,
    'lightcyan': Color.rgb(224, 255, 255) as RgbColor,
    'lightgoldenrodyellow': Color.rgb(250, 250, 210) as RgbColor,
    'lightgray': Color.rgb(211, 211, 211) as RgbColor,
    'lightgreen': Color.rgb(144, 238, 144) as RgbColor,
    'lightgrey': Color.rgb(211, 211, 211) as RgbColor,
    'lightpink': Color.rgb(255, 182, 193) as RgbColor,
    'lightsalmon': Color.rgb(255, 160, 122) as RgbColor,
    'lightseagreen': Color.rgb(32, 178, 170) as RgbColor,
    'lightskyblue': Color.rgb(135, 206, 250) as RgbColor,
    'lightslategray': Color.rgb(119, 136, 153) as RgbColor,
    'lightslategrey': Color.rgb(119, 136, 153) as RgbColor,
    'lightsteelblue': Color.rgb(176, 196, 222) as RgbColor,
    'lightyellow': Color.rgb(255, 255, 224) as RgbColor,
    'lime': Color.rgb(0, 255, 0) as RgbColor,
    'limegreen': Color.rgb(50, 205, 50) as RgbColor,
    'linen': Color.rgb(250, 240, 230) as RgbColor,
    'magenta': Color.rgb(255, 0, 255) as RgbColor,
    'maroon': Color.rgb(128, 0, 0) as RgbColor,
    'mediumaquamarine': Color.rgb(102, 205, 170) as RgbColor,
    'mediumblue': Color.rgb(0, 0, 205) as RgbColor,
    'mediumorchid': Color.rgb(186, 85, 211) as RgbColor,
    'mediumpurple': Color.rgb(147, 112, 219) as RgbColor,
    'mediumseagreen': Color.rgb(60, 179, 113) as RgbColor,
    'mediumslateblue': Color.rgb(123, 104, 238) as RgbColor,
    'mediumspringgreen': Color.rgb(0, 250, 154) as RgbColor,
    'mediumturquoise': Color.rgb(72, 209, 204) as RgbColor,
    'mediumvioletred': Color.rgb(199, 21, 133) as RgbColor,
    'midnightblue': Color.rgb(25, 25, 112) as RgbColor,
    'mintcream': Color.rgb(245, 255, 250) as RgbColor,
    'mistyrose': Color.rgb(255, 228, 225) as RgbColor,
    'moccasin': Color.rgb(255, 228, 181) as RgbColor,
    'navajowhite': Color.rgb(255, 222, 173) as RgbColor,
    'navy': Color.rgb(0, 0, 128) as RgbColor,
    'oldlace': Color.rgb(253, 245, 230) as RgbColor,
    'olive': Color.rgb(128, 128, 0) as RgbColor,
    'olivedrab': Color.rgb(107, 142, 35) as RgbColor,
    'orange': Color.rgb(255, 165, 0) as RgbColor,
    'orangered': Color.rgb(255, 69, 0) as RgbColor,
    'orchid': Color.rgb(218, 112, 214) as RgbColor,
    'palegoldenrod': Color.rgb(238, 232, 170) as RgbColor,
    'palegreen': Color.rgb(152, 251, 152) as RgbColor,
    'paleturquoise': Color.rgb(175, 238, 238) as RgbColor,
    'palevioletred': Color.rgb(219, 112, 147) as RgbColor,
    'papayawhip': Color.rgb(255, 239, 213) as RgbColor,
    'peachpuff': Color.rgb(255, 218, 185) as RgbColor,
    'peru': Color.rgb(205, 133, 63) as RgbColor,
    'pink': Color.rgb(255, 192, 203) as RgbColor,
    'plum': Color.rgb(221, 160, 221) as RgbColor,
    'powderblue': Color.rgb(176, 224, 230) as RgbColor,
    'purple': Color.rgb(128, 0, 128) as RgbColor,
    'rebeccapurple': Color.rgb(102, 51, 153) as RgbColor,
    'red': Color.rgb(255, 0, 0) as RgbColor,
    'rosybrown': Color.rgb(188, 143, 143) as RgbColor,
    'royalblue': Color.rgb(65, 105, 225) as RgbColor,
    'saddlebrown': Color.rgb(139, 69, 19) as RgbColor,
    'salmon': Color.rgb(250, 128, 114) as RgbColor,
    'sandybrown': Color.rgb(244, 164, 96) as RgbColor,
    'seagreen': Color.rgb(46, 139, 87) as RgbColor,
    'seashell': Color.rgb(255, 245, 238) as RgbColor,
    'sienna': Color.rgb(160, 82, 45) as RgbColor,
    'silver': Color.rgb(192, 192, 192) as RgbColor,
    'skyblue': Color.rgb(135, 206, 235) as RgbColor,
    'slateblue': Color.rgb(106, 90, 205) as RgbColor,
    'slategray': Color.rgb(112, 128, 144) as RgbColor,
    'slategrey': Color.rgb(112, 128, 144) as RgbColor,
    'snow': Color.rgb(255, 250, 250) as RgbColor,
    'springgreen': Color.rgb(0, 255, 127) as RgbColor,
    'steelblue': Color.rgb(70, 130, 180) as RgbColor,
    'tan': Color.rgb(210, 180, 140) as RgbColor,
    'teal': Color.rgb(0, 128, 128) as RgbColor,
    'thistle': Color.rgb(216, 191, 216) as RgbColor,
    'tomato': Color.rgb(255, 99, 71) as RgbColor,
    'turquoise': Color.rgb(64, 224, 208) as RgbColor,
    'violet': Color.rgb(238, 130, 238) as RgbColor,
    'wheat': Color.rgb(245, 222, 179) as RgbColor,
    'white': Color.rgb(255, 255, 255) as RgbColor,
    'whitesmoke': Color.rgb(245, 245, 245) as RgbColor,
    'yellow': Color.rgb(255, 255, 0) as RgbColor,
    'yellowgreen': Color.rgb(154, 205, 50) as RgbColor,
  };
}
