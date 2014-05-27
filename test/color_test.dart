import '../lib/color.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

void main() {
  print("Running");
  useHtmlConfiguration();

  group("A Color can be constructed ", () {
    test("through the default constructor", () {
      Color color = new Color();
      expect(color is Color, isTrue);
    });
    test("through the Color.rgb constructor", () {
      Color color = new Color.rgb(192, 255, 238);
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("through the Color.hex constructor", () {
      Color color = new Color.hex('c0ffee');
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
    test("through the Color.hsl constructor", () {
      Color color = new Color.hsl(163.8, 100, 87.6);
      expect(color is Color, isTrue);
      expect(color.r, equals(192));
      expect(color.g, equals(255));
      expect(color.b, equals(238));
    });
  });
  group("A Color can be converted to a string ", () {
    test("through the Color.toString() method", () {
      Color color = new Color.rgb(192, 255, 238);
      String string = color.toString();
      expect(string, equals('r: 192, g: 255, b: 238'));
    });
    test("through the Color.toRgbString() method", () {
      Color color = new Color.rgb(192, 255, 238);
      String string = color.toRgbString();
      expect(string, equals('r: 192, g: 255, b: 238'));
    });
    test("through the Color.toHexString() method", () {
      Color color = new Color.hex('c0ffee');
      String string = color.toHexString();
      expect(string, equals('c0ffee'));
    });
    test("through the Color.toHslString() method", () {
      Color color = new Color.hsl(163.8, 100, 87.6);
      String string = color.toHslString();
      expect(string, equals('h: 164, s: 100.0%, l: 87.6%'));
    });
    test("and hex strings are prepended with 0s properly", () {
      Color black = new Color.hex('000000');
      Color green = new Color.hex('00ff00');
      expect(black.toHexString(), equals('000000'));
      expect(green.toHexString(), equals('00ff00'));
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
    Map<String, int> rgb;
    Map<String, String> hex;
    Map<String, num> hsl;
    String hexString;
    setUp(() {
      rgb = {
        'r': 192,
        'g': 255,
        'b': 238
      };
      hex = {
        'r': 'c0',
        'g': 'ff',
        'b': 'ee'
      };
      hsl = {
        'h': 163.8,
        's': 100,
        'l': 87.6
      };
      hexString = 'c0ffee';
    });
    test("from rgb to hex", () {
      Map<String, String> conversion = Color.rgbToHex(rgb['r'], rgb['g'], rgb['b']);
      expect(conversion, equals(hex));
    });
    test("from rgb to hsl", () {
      Map<String, num> conversion = Color.rgbToHsl(rgb['r'], rgb['g'], rgb['b']);
      conversion.forEach((String key, num value) {
        conversion[key] = num.parse(value.toStringAsFixed(1));
      });
      expect(conversion, equals(hsl));
    });
    test("from hex to rgb", () {
      Map<String, int> conversion = Color.hexToRgb(hexString);
      expect(conversion, equals(rgb));
    });
    test("from hex to hsl", () {
      Map<String, num> conversion = Color.hexToHsl(hexString);
      conversion.forEach((String key, num value) {
        conversion[key] = num.parse(value.toStringAsFixed(1));
      });
      expect(conversion, equals(hsl));
    });
    test("from hsl to rgb", () {
      Map<String, int> conversion = Color.hslToRgb(hsl['h'], hsl['s'], hsl['l']);
      expect(conversion, equals(rgb));
    });
    test("from hsl to hex", () {
      Map<String, String> conversion = Color.hslToHex(hsl['h'], hsl['s'], hsl['l']);
      expect(conversion, equals(hex));
    });
  });
}