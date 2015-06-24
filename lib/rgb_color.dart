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

  /**
   * Creates a [Color] using a vector describing its red, green, and blue
   * values.
   *
   * The value for [r], [g], and [b] should be in the range between 0 and
   * 255 (inclusive).  Values above this range will be assumed to be a value
   * of 255, and values below this range will be assumed to be a value of 0.
   */
  const RgbColor(num this.r, num this.g, num this.b);

  factory RgbColor.name(String name) {
    if (RgbColor.namedColors.containsKey(name)) {
      return RgbColor.namedColors[name];
    } else {
      throw new ArgumentError(
          "Only the color names defined by the CSS3 spec are supported. See http://www.w3.org/TR/css3-color/#svg-color for a list of valid color names.");
    }
  }

  RgbColor toRgbColor() => this;

  HslColor toHslColor() {
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

    if (hue.isNaN || hue.isInfinite) {
      hue = 0;
    }

    luminance = (cMax + cMin) / 2;

    if (delta == 0) {
      saturation = 0;
    } else {
      saturation = delta / (1 - (luminance * 2 - 1).abs());
    }

    return new HslColor(hue, saturation * 100, luminance * 100);
  }

  XyzColor toXyzColor() {
    Map<String, num> rgb = {'r': r / 255, 'g': g / 255, 'b': b / 255};

    rgb.forEach((key, value) {
      if (value > 0.04045) {
        rgb[key] = pow((value + 0.055) / 1.055, 2.4);
      } else {
        rgb[key] = value / 12.92;
      }
      rgb[key] *= 100;
    });

    num x = rgb['r'] * 0.4124 + rgb['g'] * 0.3576 + rgb['b'] * 0.1805;
    num y = rgb['r'] * 0.2126 + rgb['g'] * 0.7152 + rgb['b'] * 0.0722;
    num z = rgb['r'] * 0.0193 + rgb['g'] * 0.1192 + rgb['b'] * 0.9505;

    return new XyzColor(x, y, z);
  }

  CielabColor toCielabColor() => this.toXyzColor().toCielabColor();

  HexColor toHexColor() => new HexColor.fromRgb(r, g, b);

  String toString() => "r: $r, g: $g, b: $b";

  String toCssString() => 'rgb(${r.toInt()}, ${g.toInt()}, ${b.toInt()})';

  Map<String, num> toMap() => {'r': r, 'g': g, 'b': b};

  static const Map<String, RgbColor> namedColors = const {
    'aliceblue': const Color.rgb(240, 248, 255),
    'antiquewhite': const Color.rgb(250, 235, 215),
    'aqua': const Color.rgb(0, 255, 255),
    'aquamarine': const Color.rgb(127, 255, 212),
    'azure': const Color.rgb(240, 255, 255),
    'beige': const Color.rgb(245, 245, 220),
    'bisque': const Color.rgb(255, 228, 196),
    'black': const Color.rgb(0, 0, 0),
    'blanchedalmond': const Color.rgb(255, 235, 205),
    'blue': const Color.rgb(0, 0, 255),
    'blueviolet': const Color.rgb(138, 43, 226),
    'brown': const Color.rgb(165, 42, 42),
    'burlywood': const Color.rgb(222, 184, 135),
    'cadetblue': const Color.rgb(95, 158, 160),
    'chartreuse': const Color.rgb(127, 255, 0),
    'chocolate': const Color.rgb(210, 105, 30),
    'coral': const Color.rgb(255, 127, 80),
    'cornflowerblue': const Color.rgb(100, 149, 237),
    'cornsilk': const Color.rgb(255, 248, 220),
    'crimson': const Color.rgb(220, 20, 60),
    'cyan': const Color.rgb(0, 255, 255),
    'darkblue': const Color.rgb(0, 0, 139),
    'darkcyan': const Color.rgb(0, 139, 139),
    'darkgoldenrod': const Color.rgb(184, 134, 11),
    'darkgray': const Color.rgb(169, 169, 169),
    'darkgreen': const Color.rgb(0, 100, 0),
    'darkgrey': const Color.rgb(169, 169, 169),
    'darkkhaki': const Color.rgb(189, 183, 107),
    'darkmagenta': const Color.rgb(139, 0, 139),
    'darkolivegreen': const Color.rgb(85, 107, 47),
    'darkorange': const Color.rgb(255, 140, 0),
    'darkorchid': const Color.rgb(153, 50, 204),
    'darkred': const Color.rgb(139, 0, 0),
    'darksalmon': const Color.rgb(233, 150, 122),
    'darkseagreen': const Color.rgb(143, 188, 143),
    'darkslateblue': const Color.rgb(72, 61, 139),
    'darkslategray': const Color.rgb(47, 79, 79),
    'darkslategrey': const Color.rgb(47, 79, 79),
    'darkturquoise': const Color.rgb(0, 206, 209),
    'darkviolet': const Color.rgb(148, 0, 211),
    'deeppink': const Color.rgb(255, 20, 147),
    'deepskyblue': const Color.rgb(0, 191, 255),
    'dimgray': const Color.rgb(105, 105, 105),
    'dimgrey': const Color.rgb(105, 105, 105),
    'dodgerblue': const Color.rgb(30, 144, 255),
    'firebrick': const Color.rgb(178, 34, 34),
    'floralwhite': const Color.rgb(255, 250, 240),
    'forestgreen': const Color.rgb(34, 139, 34),
    'fuchsia': const Color.rgb(255, 0, 255),
    'gainsboro': const Color.rgb(220, 220, 220),
    'ghostwhite': const Color.rgb(248, 248, 255),
    'gold': const Color.rgb(255, 215, 0),
    'goldenrod': const Color.rgb(218, 165, 32),
    'gray': const Color.rgb(128, 128, 128),
    'green': const Color.rgb(0, 128, 0),
    'greenyellow': const Color.rgb(173, 255, 47),
    'grey': const Color.rgb(128, 128, 128),
    'honeydew': const Color.rgb(240, 255, 240),
    'hotpink': const Color.rgb(255, 105, 180),
    'indianred': const Color.rgb(205, 92, 92),
    'indigo': const Color.rgb(75, 0, 130),
    'ivory': const Color.rgb(255, 255, 240),
    'khaki': const Color.rgb(240, 230, 140),
    'lavender': const Color.rgb(230, 230, 250),
    'lavenderblush': const Color.rgb(255, 240, 245),
    'lawngreen': const Color.rgb(124, 252, 0),
    'lemonchiffon': const Color.rgb(255, 250, 205),
    'lightblue': const Color.rgb(173, 216, 230),
    'lightcoral': const Color.rgb(240, 128, 128),
    'lightcyan': const Color.rgb(224, 255, 255),
    'lightgoldenrodyellow': const Color.rgb(250, 250, 210),
    'lightgray': const Color.rgb(211, 211, 211),
    'lightgreen': const Color.rgb(144, 238, 144),
    'lightgrey': const Color.rgb(211, 211, 211),
    'lightpink': const Color.rgb(255, 182, 193),
    'lightsalmon': const Color.rgb(255, 160, 122),
    'lightseagreen': const Color.rgb(32, 178, 170),
    'lightskyblue': const Color.rgb(135, 206, 250),
    'lightslategray': const Color.rgb(119, 136, 153),
    'lightslategrey': const Color.rgb(119, 136, 153),
    'lightsteelblue': const Color.rgb(176, 196, 222),
    'lightyellow': const Color.rgb(255, 255, 224),
    'lime': const Color.rgb(0, 255, 0),
    'limegreen': const Color.rgb(50, 205, 50),
    'linen': const Color.rgb(250, 240, 230),
    'magenta': const Color.rgb(255, 0, 255),
    'maroon': const Color.rgb(128, 0, 0),
    'mediumaquamarine': const Color.rgb(102, 205, 170),
    'mediumblue': const Color.rgb(0, 0, 205),
    'mediumorchid': const Color.rgb(186, 85, 211),
    'mediumpurple': const Color.rgb(147, 112, 219),
    'mediumseagreen': const Color.rgb(60, 179, 113),
    'mediumslateblue': const Color.rgb(123, 104, 238),
    'mediumspringgreen': const Color.rgb(0, 250, 154),
    'mediumturquoise': const Color.rgb(72, 209, 204),
    'mediumvioletred': const Color.rgb(199, 21, 133),
    'midnightblue': const Color.rgb(25, 25, 112),
    'mintcream': const Color.rgb(245, 255, 250),
    'mistyrose': const Color.rgb(255, 228, 225),
    'moccasin': const Color.rgb(255, 228, 181),
    'navajowhite': const Color.rgb(255, 222, 173),
    'navy': const Color.rgb(0, 0, 128),
    'oldlace': const Color.rgb(253, 245, 230),
    'olive': const Color.rgb(128, 128, 0),
    'olivedrab': const Color.rgb(107, 142, 35),
    'orange': const Color.rgb(255, 165, 0),
    'orangered': const Color.rgb(255, 69, 0),
    'orchid': const Color.rgb(218, 112, 214),
    'palegoldenrod': const Color.rgb(238, 232, 170),
    'palegreen': const Color.rgb(152, 251, 152),
    'paleturquoise': const Color.rgb(175, 238, 238),
    'palevioletred': const Color.rgb(219, 112, 147),
    'papayawhip': const Color.rgb(255, 239, 213),
    'peachpuff': const Color.rgb(255, 218, 185),
    'peru': const Color.rgb(205, 133, 63),
    'pink': const Color.rgb(255, 192, 203),
    'plum': const Color.rgb(221, 160, 221),
    'powderblue': const Color.rgb(176, 224, 230),
    'purple': const Color.rgb(128, 0, 128),
    'rebeccapurple': const Color.rgb(102, 51, 153),
    'red': const Color.rgb(255, 0, 0),
    'rosybrown': const Color.rgb(188, 143, 143),
    'royalblue': const Color.rgb(65, 105, 225),
    'saddlebrown': const Color.rgb(139, 69, 19),
    'salmon': const Color.rgb(250, 128, 114),
    'sandybrown': const Color.rgb(244, 164, 96),
    'seagreen': const Color.rgb(46, 139, 87),
    'seashell': const Color.rgb(255, 245, 238),
    'sienna': const Color.rgb(160, 82, 45),
    'silver': const Color.rgb(192, 192, 192),
    'skyblue': const Color.rgb(135, 206, 235),
    'slateblue': const Color.rgb(106, 90, 205),
    'slategray': const Color.rgb(112, 128, 144),
    'slategrey': const Color.rgb(112, 128, 144),
    'snow': const Color.rgb(255, 250, 250),
    'springgreen': const Color.rgb(0, 255, 127),
    'steelblue': const Color.rgb(70, 130, 180),
    'tan': const Color.rgb(210, 180, 140),
    'teal': const Color.rgb(0, 128, 128),
    'thistle': const Color.rgb(216, 191, 216),
    'tomato': const Color.rgb(255, 99, 71),
    'turquoise': const Color.rgb(64, 224, 208),
    'violet': const Color.rgb(238, 130, 238),
    'wheat': const Color.rgb(245, 222, 179),
    'white': const Color.rgb(255, 255, 255),
    'whitesmoke': const Color.rgb(245, 245, 245),
    'yellow': const Color.rgb(255, 255, 0),
    'yellowgreen': const Color.rgb(154, 205, 50)
  };
}
