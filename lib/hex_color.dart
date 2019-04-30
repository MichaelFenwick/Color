part of color;

class HexColor extends RgbaColor {
  /**
   * Creates a [HexColor] using a [String] describing its RGBA value in hex.
   *
   * The [hexCode] should be a string of 6 characters, each of which is a
   * valid hex character (0 through 9 and A through F).  Capital and lowercase
   * letters will work equally well.  Characters after the first 6 characters
   * will be ignored.  If non-valid hex characters are encountered, a
   * [FormatException] will be thrown.
   *
   * The [hexCode] should not be preceeded with a pound sign (#).
   */
  factory HexColor(String hexCode) {
    if (hexCode.startsWith('#')) {
      hexCode = hexCode.substring(1);
    }

    hexCode = hexCode.padRight(8, 'f');

    int hexToInt(String twoDigitHex) => int.parse(twoDigitHex, radix: 16);

    int red = hexToInt(hexCode.substring(0, 2));
    int green = hexToInt(hexCode.substring(2, 4));
    int blue = hexToInt(hexCode.substring(4, 6));
    double opacity = RgbaColor.alphaToOpacity(hexToInt(hexCode.substring(6)));

    return new HexColor.fromRgba(red, green, blue, opacity);
  }

  const HexColor.fromRgb(num red, num green, num blue)
      : super(red, green, blue);

  const HexColor.fromRgba(num red, num green, num blue, double opacity)
      : super(red, green, blue, opacity);

  get rHex => numToToDigitHex(r);

  get gHex => numToToDigitHex(g);

  get bHex => numToToDigitHex(b);

  get opacityHex => numToToDigitHex(_opacity * RgbaColor.maxAlpha);

  HexColor toHexColor() => this;

  // TODO: Create extra method with parameter where you can choose whether to include the opacity or not.
  String toString() =>
      _opacity == RgbaColor.maxOpacity
          ? '#$rHex$gHex$bHex'
          : '#$rHex$gHex$bHex$opacityHex';

  // -----
  // Helpers
  // -----
  String numToToDigitHex(num value) =>
      value.round().toRadixString(16).padLeft(2, '0');
}
