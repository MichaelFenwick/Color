part of color;

class HexColor extends RgbColor implements CssColorSpace {
  /// Creates a [HexColor] using a [String] describing its RGB value in hex.
  ///
  /// The [hexCode] should be a string of 6 characters, each of which is a
  /// valid hex character (0 through 9 and A through F).  Capital and lowercase
  /// letters will work equally well.  Characters after the first 6 characters
  /// will be ignored.  If non-valid hex characters are encountered, a
  /// [FormatException] will be thrown.
  ///
  /// The [hexCode] should not be preceeded with a pound sign (#).
  factory HexColor(String hexCode) {
    if (hexCode.startsWith('#')) {
      hexCode = hexCode.substring(1);
    }
    var hexDigits = hexCode.split('');
    var r = int.parse(hexDigits.sublist(0, 2).join(), radix: 16);
    var g = int.parse(hexDigits.sublist(2, 4).join(), radix: 16);
    var b = int.parse(hexDigits.sublist(4).join(), radix: 16);
    return HexColor.fromRgb(r, g, b);
  }

  const HexColor.fromRgb(num r, num g, num b) : super(r, g, b);

  String get rHex => r.toInt().toRadixString(16).padLeft(2, '0');
  String get gHex => g.toInt().toRadixString(16).padLeft(2, '0');
  String get bHex => b.toInt().toRadixString(16).padLeft(2, '0');

  @override
  HexColor toHexColor() => this;

  @override
  String toString() => '$rHex$gHex$bHex';

  @override
  String toCssString() => '#$rHex$gHex$bHex';
}
