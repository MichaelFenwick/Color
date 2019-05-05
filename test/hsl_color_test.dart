import 'package:color/color.dart';
import 'package:color/hsl_color.dart';
import 'package:color/rgb_color.dart';
import 'package:test/test.dart';

void main() {
  group("Should construct a HslColor", () {
    test(
        "with max opacity when using the HslColor.fromHslo constructor with no opacity supplied",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      expect(color.opacity, Color.maxOpacity);
      expect(color.hue, 100);
      expect(color.saturation, 80);
      expect(color.lightness, 50);
    });
    test(
        "with opacity when using the HslColor.fromHslo constructor with opacity supplied",
        () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      expect(color.opacity, 0.5);
      expect(color.hue, 100);
      expect(color.saturation, 80);
      expect(color.lightness, 50);
    });
  });

  group("Should return a new manipulated instance", () {
    test("with the changed opacity when changing the opacity.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      final newColor = color.withOpacity(0.25);
      expect(newColor.opacity, 0.25);
    });
    test("with the changed opacity when changing the opacity.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      final newColor = color.withOpacity(0.25);
      expect(newColor.opacity, 0.25);
    });
    test("with the changed lightness when lightening by steps.", () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.lightenBySteps(10);
      expect(newColor.lightness, color.lightness + 10);
    });
    test(
        "with the changed lightness brought into range when lightening to an out of bounds value by steps.",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.lightenBySteps(60);
      expect(newColor.lightness, 10);
    });
    test("with the changed lightness when lightening by fraction.", () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.lightenByFraction(0.5);
      expect(newColor.lightness, 75);
    });
    test(
        "with the changed lightness brought into range when lightening to an out of bounds value by fraction.",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.lightenByFraction(2);
      expect(newColor.lightness, 50);
    });
    test("with the changed lightness when setting the lightness.", () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.withLightness(60);
      expect(newColor.lightness, 60);
    });
    test(
        "with the changed lightness brought into range when setting the lightness to an out of bounds value.",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.withLightness(110);
      expect(newColor.lightness, 10);
    });
    test("with the changed lightness when darkening by steps.", () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.darkenBySteps(10);
      expect(newColor.lightness, color.lightness - 10);
    });
    test(
        "with the changed lightness brought into range when darkening to an out of bounds value by steps.",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.darkenBySteps(60);
      expect(newColor.lightness, 90);
    });
    test("with the changed lightness when darkening by fraction.", () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.darkenByFraction(0.5);
      expect(newColor.lightness, color.lightness / 2);
    });
    test(
        "with the changed lightness brought into range when darkening to an out of bounds value by steps.",
        () {
      final color = HslColor.fromHslo(hue: 100, saturation: 80, lightness: 50);
      final newColor = color.darkenByFraction(1.5);
      expect(newColor.lightness, 75);
    });
  });

  group("Should return a converted instance", () {
    test(
        "of RgbColor when using the to Rgb conversion function on an HslColor.",
        () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      final rgbColor = color.toRgb();
      expect(rgbColor, TypeMatcher<RgbColor>());
      expect(rgbColor.opacity, color.opacity);
      expect(rgbColor.red, 93);
      expect(rgbColor.green, 230);
      expect(rgbColor.blue, 25);
    });
    test(
        "of HslColor when unsing the to Hsl conversion function on an HslColor.",
        () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      final hslColor = color.toHsl();
      expect(hslColor, TypeMatcher<HslColor>());
      expect(hslColor, equals(color));
    });
  });

  group("Should return the correct value when getting the", () {
    test("opacity of an HslColor.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      expect(color.opacity, 0.5);
    });
    test("hue value of an HslColor.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      expect(color.hue, 100);
    });
    test("saturation of an HslColor.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      expect(color.saturation, 80);
    });
    test("lightness of an HslColor.", () {
      final color = HslColor.fromHslo(
          hue: 100, saturation: 80, lightness: 50, opacity: 0.5);
      expect(color.lightness, 50);
    });
  });
}
