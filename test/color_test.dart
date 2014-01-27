import '../lib/color.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

void main() {
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
      Color color = new Color.hsl(164, 100, 87.6);
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
    test("through the Color.toHexString() method", () {
      Color color = new Color.hex('c0ffee');
      String string = color.toHexString();
      expect(string, equals('c0ffee'));
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
}