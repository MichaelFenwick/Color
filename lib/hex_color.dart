part of color;

class HexColor extends RgbColor {

  /**
   * Creates a [HexColor] using a [String] describing its RGB value in hex.
   *
   * The [hexCode] should be a string of 6 characters, each of which is a
   * valid hex character (0 through 9 and A through F).  Capital and lowercase
   * letters will work equally well.  Characters after the first 6 characters
   * will be ignored.  If non-valid hex characters are encountered, a
   * [FormatException] will be thrown.
   *
   * The [hexCode] should not be preceeded with a pound sign (#).
   */
  HexColor(String hexCode) : super(0, 0, 0) {
    List<String> hexDigits = hexCode.split('');
    _r = int.parse(hexDigits.sublist(0, 2).join(), radix: 16);
    _g = int.parse(hexDigits.sublist(2, 4).join(), radix: 16);
    _b = int.parse(hexDigits.sublist(4).join(), radix: 16);
  }

  HexColor.fromRgb(int r, int g, int b) : super(r, g, b);

  get r => _r;
  get g => _g;
  get b => _b;

  get rHex => _r.toRadixString(16).padLeft(2, '0');
  get gHex => _g.toRadixString(16).padLeft(2, '0');
  get bHex => _b.toRadixString(16).padLeft(2, '0');

  set r(int r) => _r = max(0, min(255, r));
  set g(int g) => _g = max(0, min(255, g));
  set b(int b) => _b = max(0, min(255, b));

  String toString() => '$rHex$gHex$bHex';

}
