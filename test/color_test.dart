import '../lib/color.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

void main() {
  useHtmlConfiguration();

  group("A Color can be constructed ", () {
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
  });
  group("Colors can be converted to a string ", () {
    test("from an RgbColor", () {
      Color color = new Color.rgb(192, 255, 238);
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
      Color color = new Color.hsl(163.8, 100.0, 87.6);
      String string = color.toString();
      expect(string, equals('h: 163.8, s: 100.0%, l: 87.6%'));
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
  group("Colors can be converted ", () {
    RgbColor rgb;
    HexColor hex;
    HslColor hsl;
    setUp(() {
      rgb = new RgbColor(192, 255, 238);
      hex = new HexColor('c0ffee');
      hsl = new HslColor(163.8, 100, 87.6);
    });
    test("from rgb to hex", () {
      HexColor conversion = rgb.toHexColor();
      expect(conversion, equals(hex));
    });
    test("from hex to rgb", () {
      RgbColor conversion = hex.toRgbColor();
      expect(conversion, equals(rgb));
    });
    test("from rgb to hsl", () {
      HslColor conversion = rgb.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from hex to hsl", () {
      HslColor conversion = hex.toHslColor();
      expect(conversion, equals(hsl));
    });
    test("from hsl to rgb", () {
      RgbColor conversion = hsl.toRgbColor();
      expect(conversion, equals(rgb));
    });
  });
}