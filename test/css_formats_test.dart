import 'package:color/color.dart';
import 'package:color/css_formats.dart';
import 'package:test/test.dart';

void main() {
  group("Should return a valid PrefixRgbFormatted CSS representation", () {
    test("with opacity when opacity mode is set to always.", () {
      final color = Color.rgb(red: 10, green: 11, blue: 12);
      final formatted =
          PrefixRgbFormat(opacityMode: OpacityMode.always, prefix: 'prefix')
              .format(color);
      expect(formatted, 'prefix(10, 11, 12, 100%)');
    });
    test(
        "with opacity when opacity mode is set to whenTransparent and the color is transparent.",
        () {
      final color = Color.rgbo(red: 10, green: 11, blue: 12, opacity: 0.5);
      final formatted = PrefixRgbFormat(
              opacityMode: OpacityMode.whenTransparent, prefix: 'prefix')
          .format(color);
      expect(formatted, 'prefix(10, 11, 12, 50%)');
    });
    test(
        "without opacity when opacity mode is set to whenTransparent and the color is not transparent.",
        () {
      final color = Color.rgbo(red: 10, green: 11, blue: 12, opacity: 1);
      final formatted = PrefixRgbFormat(
              opacityMode: OpacityMode.whenTransparent, prefix: 'prefix')
          .format(color);
      expect(formatted, 'prefix(10, 11, 12)');
    });
    test("without opacity when opacity mode is set to never.", () {
      final color = Color.rgbo(red: 10, green: 11, blue: 12, opacity: 0.5);
      final formatted =
          PrefixRgbFormat(opacityMode: OpacityMode.never, prefix: 'prefix')
              .format(color);
      expect(formatted, 'prefix(10, 11, 12)');
    });
    test("with the rgb values as percent.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51);
      final formatted =
          PrefixRgbFormat(rgbStyle: PercentOrDecimal.percent, prefix: 'prefix')
              .format(color);
      expect(formatted, 'prefix(20%, 20%, 20%)');
    });
    test("with the rgb values as decimal.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51);
      final formatted =
          PrefixRgbFormat(rgbStyle: PercentOrDecimal.decimal, prefix: 'prefix')
              .format(color);
      expect(formatted, 'prefix(51, 51, 51)');
    });
    test("with the opacity value as percent.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51, opacity: 0.5);
      final formatted = PrefixRgbFormat(
              opacityStyle: PercentOrDecimal.percent, prefix: 'prefix')
          .format(color);
      expect(formatted, 'prefix(51, 51, 51, 50%)');
    });
    test("with the opacity value as decimal.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51, opacity: 0.5);
      final formatted = PrefixRgbFormat(
              opacityStyle: PercentOrDecimal.decimal, prefix: 'prefix')
          .format(color);
      expect(formatted, 'prefix(51, 51, 51, 0.50)');
    });
  });

  group("Should return a correctly prefixed CSS representation when using", () {
    test("the RgbFormat.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51, opacity: 0.5);
      final formatted = RgbFormat().format(color);
      expect(formatted, startsWith('rgb'));
    });
    test("the RgbaFormat.", () {
      final color = Color.rgbo(red: 51, green: 51, blue: 51, opacity: 0.5);
      final formatted = RgbaFormat().format(color);
      expect(formatted, startsWith('rgba'));
    });
  });
}
