import 'package:color/hsl_color.dart';
import 'package:color/rgb_color.dart';
import 'package:test/test.dart';

void main() {
  group("Should construct a RgbColor", () {
    test(
        "with min alpha when using the RgbColor constructor with only 6 bytes supplied.",
        () {
      final color = RgbColor(0x345678);
      expect(color.alpha, RgbColor.minAlpha);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with alpha when using the RgbColor constructor with 8 bytes supplied.",
        () {
      final color = RgbColor(0x12345678);
      expect(color.alpha, 18);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with the value brought into range when using the RgbColor constructor with more thatn 8 bytes supplied.",
        () {
      final color = RgbColor.fromHex(0x9A34567812);
      expect(color.alpha, 18);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with max alpha when using the RgbColor.fromHex constructor with only 6 bytes supplied.",
        () {
      final color = RgbColor.fromHex(0x345678);
      expect(color.alpha, RgbColor.maxAlpha);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with alpha when using the RgbColor.fromHex constructor with 8 bytes supplied.",
        () {
      final color = RgbColor.fromHex(0x34567812);
      expect(color.alpha, 18);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with the hex value brought into range when using the RgbColor.fromHex constructor with an out of range hex value.",
        () {
      final color = RgbColor.fromHex(0x9A34567812);
      expect(color.alpha, 18);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with max alpha when using the RgbColor.fromRgba constructor with no alpha supplied.",
        () {
      final color = RgbColor.fromRgba(red: 52, green: 86, blue: 120);
      expect(color.alpha, RgbColor.maxAlpha);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with alpha when using the RgbColor.fromRgba constructor with alpha supplied.",
        () {
      final color = RgbColor.fromRgba(red: 52, green: 86, blue: 120, alpha: 12);
      expect(color.alpha, 12);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with the alpha value brought into range when using the RgbColor.fromRgba constructor with an out of range alpha value.",
        () {
      final color = RgbColor.fromRgba(red: 0, green: 0, blue: 0, alpha: 257);
      expect(color.alpha, 1);
    });
    test(
        "with the red value brought into range when using the RgbColor.fromRgba constructor with an out of range red value.",
        () {
      final color = RgbColor.fromRgba(red: 257, green: 0, blue: 0);
      expect(color.red, 1);
    });
    test(
        "with the green value brought into range when using the RgbColor.fromRgba constructor with an out of range green value.",
        () {
      final color = RgbColor.fromRgba(red: 0, green: 257, blue: 0);
      expect(color.green, 1);
    });
    test(
        "with the blue value brought into range when using the RgbColor.fromRgba constructor with an out of range blue value.",
        () {
      final color = RgbColor.fromRgba(red: 0, green: 0, blue: 257);
      expect(color.blue, 1);
    });
    test(
        "with max alpha when using the RgbColor.fromRgbo constructor with no opacity supplied.",
        () {
      final color = RgbColor.fromRgbo(red: 52, green: 86, blue: 120);
      expect(color.alpha, RgbColor.maxAlpha);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with alpha when using the RgbColor.fromRgbo constructor with opacity supplied.",
        () {
      final color =
          RgbColor.fromRgbo(red: 52, green: 86, blue: 120, opacity: 0.05);
      expect(color.alpha, 13);
      expect(color.red, 52);
      expect(color.green, 86);
      expect(color.blue, 120);
    });
    test(
        "with the opacity value brought into range when using the RgbColor.fromRgbo constructor with an out of range opacity value.",
        () {
      final color = RgbColor.fromRgbo(red: 0, green: 0, blue: 0, opacity: 1.2);
      expect(color.opacity, 0.2);
    });
    test(
        "with the red value brought into range when using the RgbColor.fromRgbo constructor with an out of range red value.",
        () {
      final color = RgbColor.fromRgbo(red: 257, green: 0, blue: 0);
      expect(color.red, 1);
    });
    test(
        "with the green value brought into range when using the RgbColor.fromRgbo constructor with an out of range green value.",
        () {
      final color = RgbColor.fromRgbo(red: 0, green: 257, blue: 0);
      expect(color.green, 1);
    });
    test(
        "with the blue value brought into range when using the RgbColor.fromRgbo constructor with an out of range blue value.",
        () {
      final color = RgbColor.fromRgbo(red: 0, green: 0, blue: 257);
      expect(color.blue, 1);
    });
  });

  group("Should return a new manipulated instance", () {
    test("with the changed alpha when changing the alpha.", () {
      final color = RgbColor.fromHex(0x123456);
      final newColor = color.withAlpha(120).toRgb();
      expect(newColor.alpha, 120);
      expect(newColor.value, 0x78123456);
    });
    test(
        "with the changed opacity and rounded up alpha when changing the opacity.",
        () {
      final color = RgbColor.fromHex(0x123456);
      final newColor = color.withOpacity(0.47).toRgb();
      expect(newColor.opacity, 0.47);
      expect(newColor.value, 0x78123456);
    });
    test(
        "with the changed opacity and rounded down alpha when changing the opacity.",
        () {
      final color = RgbColor.fromHex(0x123456);
      final newColor = color.withOpacity(0.48).toRgb();
      expect(newColor.opacity, 0.48);
      expect(newColor.value, 0x7a123456);
    });
  });

  group("Should return a converted instance", () {
    test(
        "of HslColor when using the to Hsl conversion function on an RgbColor.",
        () {
      final color = RgbColor.fromHex(0x123456).withOpacity(0.5);
      final hslColor = color.toHsl();
      expect(hslColor, TypeMatcher<HslColor>());
      expect(hslColor.opacity, color.opacity);
      expect(hslColor.hue, 210);
      expect(hslColor.saturation, 65.38);
      expect(hslColor.lightness, 20.39);
    });
    test(
        "of RgbColor when unsing the to Rgb conversion function on an RgbColor.",
        () {
      final color = RgbColor.fromHex(0x123456).withOpacity(0.5);
      final rgbColor = color.toRgb();
      expect(rgbColor, TypeMatcher<RgbColor>());
      expect(rgbColor, equals(color));
    });
  });

  group("Should return the correct value when getting the", () {
    test("opacity of an RgbColor.", () {
      final color = RgbColor.fromHex(0x123456).withOpacity(0.5);
      expect(color.opacity, 0.5);
    });
    test("alpha value of an RgbColor.", () {
      final color = RgbColor.fromHex(0x12345678).toRgb();
      expect(color.alpha, 120);
    });
    test("red value of an RgbColor.", () {
      final color = RgbColor.fromHex(0x123456).toRgb();
      expect(color.red, 18);
    });
    test("alpha value of an RgbColor.", () {
      final color = RgbColor.fromHex(0x123456).toRgb();
      expect(color.green, 52);
    });
    test("alpha value of an RgbColor.", () {
      final color = RgbColor.fromHex(0x123456).toRgb();
      expect(color.blue, 86);
    });
  });
}
