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
    test("as a HslColor", () {
      HslColor color = new HslColor(163.8, 100, 87.6);
      expect(color is Color, isTrue);
      expect(color.h, equals(163.8));
      expect(color.s, equals(100));
      expect(color.l, equals(87.6));
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
      Color color = const Color.rgb(192, 255, 238);
      String string = color.toString();
      expect(string, equals('r: 192, g: 255, b: 238'));
    });
    test("from a HexColor", () {
      Color color = new Color.hex('c0ffee');
      String string = color.toString();
      expect(string, equals('c0ffee'));
    });
    test("and hex strings are prepended with 0s properly", () {
      Color black = new Color.hex('000000');
      Color green = new Color.hex('00ff00');
      expect(black.toString(), equals('000000'));
      expect(green.toString(), equals('00ff00'));
    });
    test("from an HslColor", () {
      Color color = const Color.hsl(163.8, 100.0, 87.6);
      String string = color.toString();
      expect(string, equals('h: 163.8, s: 100.0%, l: 87.6%'));
    });
    test("from a XyzColor", () {
      Color color = const Color.xyz(72.931, 88.9, 94.204);
      String string = color.toString();
      expect(string, equals('x: 72.931, y: 88.9, z: 94.204'));
    });
    test("from an CielabColor", () {
      Color color = const Color.cielab(95.538, -23.02, 1.732);
      String string = color.toString();
      expect(string, equals('l: 95.538, a: -23.02, b: 1.732'));
    });
  });
  group("Colors can be converted to css style strings", () {
    test("from an RgbColor", () {
      RgbColor color = const Color.rgb(192, 255, 238);
      String string = color.toCssString();
      expect(string, equals('rgb(192, 255, 238)'));
    });
    test("from a HexColor", () {
      HexColor color = new Color.hex('c0ffee');
      String string = color.toCssString();
      expect(string, equals('#c0ffee'));
    });
    test("and hex strings are prepended with 0s properly", () {
      HexColor black = new Color.hex('000000');
      HexColor green = new Color.hex('00ff00');
      expect(black.toCssString(), equals('#000000'));
      expect(green.toCssString(), equals('#00ff00'));
    });
    test("from an HslColor", () {
      HslColor color = const Color.hsl(163.8, 100.0, 87.6);
      String string = color.toCssString();
      expect(string, equals('hsl(163.8, 100.0%, 87.6%)'));
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
      expect(conversion, equals(hsl));
    });
    test("from hex to cielab", () {
      CielabColor conversion = hex.toCielabColor();
      expect(conversion, equals(hsl));
    });

    test("from hsl to rgb", () {
      RgbColor conversion = hsl.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from hsl to xyz", () {
      XyzColor conversion = hsl.toXyzColor();
      expect(conversion, equals(hsl));
    });
    test("from hsl to cielab", () {
      CielabColor conversion = hsl.toCielabColor();
      expect(conversion, equals(hsl));
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
      expect(conversion, equals(hsl));
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
      expect(conversion, equals(hsl));
    });
  });
}
