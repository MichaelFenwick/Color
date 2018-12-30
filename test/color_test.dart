import '../lib/color.dart';
import 'package:test/test.dart';

void main() {
  group("A Color can be constructed", () {
    test("through the Color.rgb constructor", () {
      RgbColor color = new Color.rgb(192, 255, 238);
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("through the Color.hex constructor", () {
      HexColor color = new Color.hex('c0ffee');
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("through the Color.hsl constructor", () {
      HslColor color = new Color.hsl(163.8, 100, 87.6);
      expect(color is Color, isTrue);
      expect(color.h, equals(163.8));
      expect(color.s, equals(100));
      expect(color.l, equals(87.6));
    });
    test("through the Color.xyz constructor", () {
      XyzColor color = new Color.xyz(72.931, 88.9, 94.204);
      expect(color is Color, isTrue);
      expect(color.x, equals(72.931));
      expect(color.y, equals(88.9));
      expect(color.z, equals(94.204));
    });
    test("through the Color.cielab constructor", () {
      CielabColor color = new Color.cielab(95.538, -23.02, 1.732);
      expect(color is Color, isTrue);
      expect(color.l, equals(95.538));
      expect(color.a, equals(-23.02));
      expect(color.b, equals(1.732));
    });
    test("as an RgbColor", () {
      RgbColor color = new RgbColor(192, 255, 238);
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("as an RgbaColor", () {
      var color = new RgbaColor(192, 255, 238, 0.5);
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
      expect(color.opacity, equals(0.5));
    });
    test("as a HexColor", () {
      HexColor color = new HexColor('c0ffee');
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("as a HexColor with leading hash", () {
      HexColor color = new HexColor('#c0ffee');
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("as a HexColoe with alpha", () {
      HexColor color = new HexColor('c0ffee80');
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
      expect(color.opacity, equals(0.5));
    });
    test("as a HslColor", () {
      HslColor color = new HslColor(163.8, 100, 87.6);
      expect(color is Color, isTrue);
      expect(color.h, equals(163.8));
      expect(color.s, equals(100));
      expect(color.l, equals(87.6));
    });
    test("as a HslaColor", () {
      var color = new HslaColor(163.8, 100, 87.6, 0.5);
      expect(color is Color, isTrue);
      expect(color.h, equals(163.8));
      expect(color.s, equals(100));
      expect(color.l, equals(87.6));
      expect(color.opacity, equals(0.5));
    });
    test("as a XyzColor", () {
      XyzColor color = new XyzColor(72.931, 88.9, 94.204);
      expect(color is Color, isTrue);
      expect(color.x, equals(72.931));
      expect(color.y, equals(88.9));
      expect(color.z, equals(94.204));
    });
    test("as a CielabColor", () {
      CielabColor color = new CielabColor(95.538, -23.02, 1.732);
      expect(color is Color, isTrue);
      expect(color.l, equals(95.538));
      expect(color.a, equals(-23.02));
      expect(color.b, equals(1.732));
    });
  });
  group("Colors can be converted to a string", () {
    test("from an RgbColor", () {
      var color = const Color.rgb(192, 255, 238);
      var string = color.toString();
      expect(string, equals('rgb(192, 255, 238)'));
    });
    test("from an RgbaColor", () {
      var color = const Color.rgba(192, 255, 238, 0.5);
      var string = color.toString();
      expect(string, equals('rgba(192, 255, 238, 0.5)'));
    });
    test("from a HexColor", () {
      Color color = new Color.hex('c0ffee');
      String string = color.toString();
      expect(string, equals('#c0ffee'));
    });
    test("from a HexColor with alpha", () {
      var color = new Color.hex('c0ffee80');
      var string = color.toString();
      expect(string, equals('#c0ffee80'));
    });
    test("and hex strings are prepended with 0s properly", () {
      var black = new Color.hex('000000');
      var green = new Color.hex('00ff00');
      expect(black.toString(), equals('#000000'));
      expect(green.toString(), equals('#00ff00'));
    });
    test("from an HslColor", () {
      var color = const Color.hsl(163.8, 100.0, 87.6);
      var string = color.toString();
      expect(string, equals('hsl(163.8, 100.0%, 87.6%)'));
    });
    test("from a XyzColor", () {
      var color = const Color.xyz(72.931, 88.9, 94.204);
      var string = color.toString();
      expect(string, equals('x: 72.931, y: 88.9, z: 94.204'));
    });
    test("from an CielabColor", () {
      var color = const Color.cielab(95.538, -23.02, 1.732);
      var string = color.toString();
      expect(string, equals('l: 95.538, a: -23.02, b: 1.732'));
    });
  });
  group("Colors can be compared to each other ", () {
    Color coffee1;
    Color coffee2;
    Color tea;
    setUp(() {
      coffee1 = new Color.hex('c0ffee');
      coffee2 = new Color.hex('c0ffee');
      tea = new Color.hex('7e47e4');
    });
    test("by comparing their hashes,", () {
      expect(coffee1.hashCode, equals(coffee2.hashCode));
      expect(coffee1.hashCode, isNot(equals(tea.hashCode)));
    });
    test("by using the == operator,", () {
      expect(coffee1, equals(coffee2));
      expect(coffee1, isNot(equals(tea)));
    });
  });
  group("Colors can be converted", () {
    RgbColor rgb;
    HexColor hex;
    HslColor hsl;
    XyzColor xyz;
    CielabColor cielab;
    setUp(() {
      rgb = const RgbColor(192, 255, 238);
      hex = new HexColor('c0ffee');
      hsl = const HslColor(163.8, 100, 87.6);
      xyz = const XyzColor(72.931, 88.9, 94.204);
      cielab = const CielabColor(95.538, -23.02, 1.732);
    });

    test("from rgb to hex", () {
      HexColor conversion = rgb.toHexColor();
      expect(conversion, equals(hex));
    });
    test("from rgb to hsl", () {
      HslColor conversion = rgb.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from rgb to xyz", () {
      XyzColor conversion = rgb.toXyzColor();
      expect(conversion, equals(xyz));
    });
    test("from rgb to cielab", () {
      CielabColor conversion = rgb.toCielabColor();
      expect(conversion, equals(cielab));
    });

    test("from hex to rgb", () {
      RgbColor conversion = hex.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from hex to hsl", () {
      HslColor conversion = hex.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from hex to xyz", () {
      XyzColor conversion = hex.toXyzColor();
      expect(conversion, equals(xyz));
    });
    test("from hex to cielab", () {
      CielabColor conversion = hex.toCielabColor();
      expect(conversion, equals(cielab));
    });

    test("from hsl to rgb", () {
      RgbColor conversion = hsl.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from hsl to xyz", () {
      XyzColor conversion = hsl.toXyzColor();
      expect(conversion, equals(xyz));
    });
    test("from hsl to cielab", () {
      CielabColor conversion = hsl.toCielabColor();
      expect(conversion, equals(cielab));
    });

    test("from xyz to rgb", () {
      RgbColor conversion = xyz.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from xyz to hsl", () {
      HslColor conversion = xyz.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from xyz to cielab", () {
      CielabColor conversion = xyz.toCielabColor();
      expect(conversion, equals(cielab));
    });

    test("from cielab to rgb", () {
      RgbColor conversion = cielab.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from cielab to hsl", () {
      HslColor conversion = cielab.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from cielab to xyz", () {
      XyzColor conversion = cielab.toXyzColor();
      expect(conversion, equals(xyz));
    });
  });
  group("Some colors can be converted to colors with opacity", () {
    RgbColor rgb;
    RgbaColor rgba;
    RgbaColor rgbaWithOpacity;
    HslColor hsl;
    HslaColor hsla;
    HslaColor hslaWithOpacity;
    setUp(() {
      rgb = const RgbColor(192, 255, 238);
      rgba = const RgbaColor(192, 255, 238, 1);
      rgbaWithOpacity = const RgbaColor(192, 255, 238, 0.5);
      hsl = const HslColor(163.8, 100, 87.6);
      hsla = const HslaColor(163.8, 100, 87.6, 1);
      hslaWithOpacity = const HslaColor(163.8, 100, 87.6, 0.5);
    });

    test("from rgb to rgba", () {
      var conversion = rgb.toRgbaColor();
      expect(conversion, equals(rgba));
    });
    test("from rgb to hsla", () {
      var conversion = rgb.toHslaColor();
      expect(conversion, equals(hsla));
    });
    test("from hsl to rgba", () {
      var conversion = hsl.toRgbaColor();
      expect(conversion, equals(rgba));
    });
    test("from hsl to hsla", () {
      var conversion = hsl.toHslaColor();
      expect(conversion, equals(hsla));
    });
    test("from rgb to rgbaWithOpacity", () {
      var conversion = rgb.withOpacity(0.5);
      expect(conversion, equals(rgbaWithOpacity));
    });
    test("from hsl to hslaWithOpacity", () {
      var conversion = hsl.withOpacity(0.5);
      expect(conversion, equals(hslaWithOpacity));
    });
  });
  group("Colors can be parsed", () {
    ColorParser parser = new ColorParser();
    test("from a named color", () {
      Color c = parser.parse("black");
      expect(c, equals(new RgbColor.name("black")));
    });
    test("from a named color with mixed case", () {
      Color c = parser.parse("Khaki");
      expect(c, equals(new RgbColor.name("khaki")));
    });
    test("from a named color, irrespective of whitespace", () {
      Color c = parser.parse("  black  ");
      expect(c, equals(new RgbColor.name("black")));
    });
    test("for all well-known name values", () {
      RgbColor.namedColors.keys.forEach(
          (key) => expect(parser.parse(key), RgbColor.namedColors[key]));
    });
    test("from an explicit hex color", () {
      Color c = parser.parse("#FFFAFA");
      expect(c, equals(new HexColor("FFFAFA")));
    });
    test("from an explicit hex color with alpha", () {
      Color c = parser.parse("#FFFAFA80");
      expect(c, equals(new HexColor("FFFAFA80")));
    });
    test("from an implicit hex color", () {
      Color c = parser.parse("FA8072");
      expect(c, equals(new HexColor("FA8072")));
    });
    test("from an implicit hex color with alpha", () {
      Color c = parser.parse("FA807280");
      expect(c, equals(new HexColor("FA807280")));
    });
    test("from an abbreviated, explicit hex color", () {
      Color c = parser.parse("#ff0");
      expect(c, equals(new HexColor("FFFF00")));
    });
    test("from an abbreviated, explicit hex color with alpha", () {
      Color c = parser.parse("#ff0e");
      expect(c, equals(new HexColor("FFFF00EE")));
    });
    test("from an abbreviated, implicit hex color", () {
      Color c = parser.parse("ff0");
      expect(c, equals(new HexColor("FFFF00")));
    });
    test("from an abbreviated, implicit hex color with alpha", () {
      Color c = parser.parse("ff0e");
      expect(c, equals(HexColor("FFFF00EE")));
    });
    test("from a hex color, irrespective of whitespace", () {
      Color c = parser.parse(" c0ffee ");
      expect(c, equals(HexColor("c0ffee")));
      Color c2 = parser.parse(" #c0ffee ");
      expect(c2, equals(HexColor("c0ffee")));
      Color c3 = parser.parse(" cfe ");
      expect(c3, equals(HexColor("ccffee")));
      Color c4 = parser.parse(" #cfe ");
      expect(c4, equals(HexColor("ccffee")));
      Color c5 = parser.parse(" c0ffee80 ");
      expect(c5, equals(HexColor("c0ffee80")));
      Color c6 = parser.parse(" #c0ffee80 ");
      expect(c6, equals(HexColor("c0ffee80")));
    });
    test("for a broad sample of legit hex codes", () {
      List<int> decimalSamples = [0, 1, 2, 126, 127, 128, 129, 254, 255];
      String _base16Padded(int decimal) =>
          decimal.toRadixString(16).padLeft(2, "0");
      decimalSamples.forEach((r) =>
          decimalSamples.forEach((g) =>
              decimalSamples.forEach((b) =>
                  expect(
                      parser.parse(
                          "${_base16Padded(r)}${_base16Padded(
                              g)}${_base16Padded(b)}"),
                      equals(new RgbColor(r, g, b))))));
    });
    test("for a broad sample of legit hex codes with alpha", () {
      List<int> decimalSamples = [0, 1, 2, 126, 127, 128, 129, 254, 255];
      String _base16Padded(int decimal) =>
          decimal.toRadixString(16).padLeft(2, "0");
      decimalSamples.forEach((r) =>
          decimalSamples.forEach((g) =>
              decimalSamples.forEach((b) =>
                  decimalSamples.forEach((a) =>
                      expect(
                          parser.parse(
                              "${_base16Padded(r)}${_base16Padded(
                                  g)}${_base16Padded(b)}${_base16Padded(a)}"),
                          equals(new RgbaColor(
                              r, g, b, RgbaColor.alphaToOpacity(a))))))));
    });
    test("from an explicit decimal rgb color", () {
      Color c = parser.parse("rgb(119,136,153)");
      expect(c, equals(new RgbColor(119, 136, 153)));
    });
    test("from an implicit decimal rgb color", () {
      Color c = parser.parse("72,61,139");
      expect(c, equals(new RgbColor(72, 61, 139)));
    });
    test("from a decimal rgb color, irrespective of whitespace", () {
      Color c = parser.parse(" 192 , 255  ,  238 ");
      expect(c, equals(new HexColor("c0ffee")));
      Color c2 = parser.parse(" rgb( 192 , 255  ,  238 ) ");
      expect(c2, equals(new HexColor("c0ffee")));
    });
    test("for a broad sample of legit decimal rgb values", () {
      List<int> decimalSamples = [0, 1, 2, 126, 127, 128, 129, 254, 255];
      decimalSamples.forEach((r) =>
          decimalSamples.forEach((g) =>
              decimalSamples.forEach((b) =>
                  expect(
                      parser.parse("$r,$g,$b"),
                      equals(new RgbColor(r, g, b))))));
    });
    test("from an explicit decimal rgba color", () {
      Color c = parser.parse("rgba(119,136,153,0.5)");
      expect(c, equals(RgbaColor(119, 136, 153, 0.5)));
    });
    test("from an implicit decimal rgba color", () {
      Color c = parser.parse("72,61,139,0.5");
      expect(c, equals(RgbaColor(72, 61, 139, 0.5)));
    });
    test("from a decimal rgba color, irrespective of whitespace", () {
      Color c = parser.parse(" 192 , 255  ,  238  ,  0.5 ");
      expect(c, equals(RgbaColor(192, 255, 238, 0.5)));
      Color c2 = parser.parse(" rgba( 192 , 255  ,  238 , 0.5) ");
      expect(c2, equals(RgbaColor(192, 255, 238, 0.5)));
    });
    test("for a broad sample of legit decimal rgba values", () {
      List<int> decimalSamples = [0, 1, 2, 126, 127, 128, 129, 254, 255];
      decimalSamples.forEach((r) =>
          decimalSamples.forEach((g) =>
              decimalSamples.forEach((b) =>
                  decimalSamples.forEach((a) =>
                      expect(
                          parser.parse("$r,$g,$b,$a"),
                          equals(new RgbaColor(
                              r, g, b, RgbaColor.alphaToOpacity(a))))))));
    });
    test("from an explicit hsl color", () {
      Color c = parser.parse("hsl(240,100%, 50%)");
      expect(c, equals(new HslColor(240, 100, 50)));
    });
    test("from an explicit hsl color, irrespective of whitespace", () {
      Color c = parser.parse("  hsl(  240  ,  100%   , 50% )  ");
      expect(c, equals(new HslColor(240, 100, 50)));
    });
    test("from an explicit hsl color, with varying decimal formats", () {
      Color c = parser.parse("hsl(0,0.25%,0.25%)");
      expect(c, equals(new HslColor(0, 0.25, 0.25)));
      Color c2 = parser.parse("hsl(0,.25%,.25%)");
      expect(c2, equals(new HslColor(0, 0.25, 0.25)));
    });
    test("for a broad sample of legit hsl values", () {
      var hueSamples = [0, 1, 2, 179, 180, 181, 359, 360, 361, 362, 719, 720];
      var percentSamples = [0.0, 0.1, 0.9, 49.0, 49.5, 50.0, 99.9999, 100.0];
      hueSamples.forEach((h) =>
          percentSamples.forEach((s) =>
              percentSamples.forEach((l) =>
                  expect(parser.parse("hsl($h,$s%,$l%)"),
                      equals(new HslColor(h, s, l))))));
    });
    test("from an explicit hsla color", () {
      Color c = parser.parse("hsla(240,100%, 50%, 0.5)");
      expect(c, equals(new HslaColor(240, 100, 50, 0.5)));
    });
    test("from an explicit hsla color, irrespective of whitespace", () {
      Color c = parser.parse("  hsla(  240  ,  100%   , 50%  ,  0.5)  ");
      expect(c, equals(new HslaColor(240, 100, 50, 0.5)));
    });
    test("from an explicit hsla color, with varying decimal formats", () {
      Color c = parser.parse("hsla(0,0.25%,0.25%, 0.5)");
      expect(c, equals(new HslaColor(0, 0.25, 0.25, 0.5)));
      Color c2 = parser.parse("hsla(0,.25%,.25%, .5)");
      expect(c2, equals(new HslaColor(0, 0.25, 0.25, 0.5)));
    });
    test("for a broad sample of legit hsl values", () {
      var hueSamples = [0, 1, 2, 179, 180, 181, 359, 360, 361, 362, 719, 720];
      var percentSamples = [0.0, 0.1, 0.9, 49.0, 49.5, 50.0, 99.9999, 100.0];
      var decimalSamples = [0.0, 0.1, 0.9, 49.0, 49.5, 50.0, 99.9999, 100.0];

      hueSamples.forEach((h) =>
          percentSamples.forEach((s) =>
              percentSamples.forEach((l) =>
                  decimalSamples.forEach((o) =>
                      expect(
                          parser.parse("hsla($h,$s%,$l%,$o)"),
                          equals(new HslaColor(h, s, l, o)))))));
    });
    test("... or else there is a fallback", () {
      Color c = parser.parse("amarillo");
      expect(c, isNull);
      Color c2 = parser.parse("azul", orElse: () => new HexColor("c0ffee"));
      expect(c2, equals(new HexColor("c0ffee")));
    });
  });
}
