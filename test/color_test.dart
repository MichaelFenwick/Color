import 'package:color/color.dart';
import 'package:color/hsl_color.dart';
import 'package:color/rgb_color.dart';
import 'package:test/test.dart';

void main() {
  group("Should construct a color", () {
    test("when using the Color.hex factory.", () {
      final color = Color.hex(0x12345678);
      expect(color, TypeMatcher<RgbColor>());
    });
    test("when using the Color.rgb factory.", () {
      final color = Color.rgb(red: 120, green: 121, blue: 122);
      expect(color, TypeMatcher<RgbColor>());
    });
    test("when using the Color.rgba factory.", () {
      final color = Color.rgba(red: 120, green: 121, blue: 122, alpha: 123);
      expect(color, TypeMatcher<RgbColor>());
    });
    test("when using the Color.rgbo factory.", () {
      final color = Color.rgbo(red: 120, green: 121, blue: 122, opacity: 0.5);
      expect(color, TypeMatcher<RgbColor>());
    });
    test("when using the Color.hsl factory.", () {
      final color = Color.hsl(hue: 10, saturation: 11, lightness: 12);
      expect(color, TypeMatcher<HslColor>());
    });
    test("when using the Color.hslo factory.", () {
      final color = Color.hslo(hue: 10, saturation: 11, lightness: 12, opacity: 0.5);
      expect(color, TypeMatcher<HslColor>());
    });
  });

  group("Should return the correct value when getting the", () {
    test("isOpaque value of a transparent Color.", () {
      final color = Color.hslo(hue: 10, saturation: 11, lightness: 12, opacity: 0.5);
      expect(color.isOpaque, false);
    });
    test("isOpaque value of an opaque Color.", () {
      final color = Color.hslo(hue: 10, saturation: 11, lightness: 12, opacity: 1);
      expect(color.isOpaque, true);
    });
    test("isTransparent value of a transparent Color.", () {
      final color = Color.hslo(hue: 10, saturation: 11, lightness: 12, opacity: 0.5);
      expect(color.isTransparent, true);
    });
    test("isTransparent value of an opaque Color.", () {
      final color = Color.hslo(hue: 10, saturation: 11, lightness: 12, opacity: 1);
      expect(color.isTransparent, false);
    });
  });
}