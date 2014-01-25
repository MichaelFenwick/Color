import 'dart:math';

class Color {
  int _r;
  int _g;
  int _b;

  Color() {}

  Color.rgb(int r, g, b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }

  Color.hex(String hexCode) {
    List<String> hexDigits = hexCode.split('');
    this.r = int.parse(hexDigits.sublist(0, 2).join(), radix: 16);
    this.g = int.parse(hexDigits.sublist(2, 4).join(), radix: 16);
    this.b = int.parse(hexDigits.sublist(4).join(), radix: 16);
  }

  get r => _r;
  get g => _g;
  get b => _b;

  set r(int r) => _r = max(0, min(255, r));
  set g(int g) => _g = max(0, min(255, g));
  set b(int b) => _b = max(0, min(255, b));

  get hashCode => 256 * 256 * r + 256 * g + b;

  operator ==(Color o) => r == o.r && g == o.g && b == o.b;

  String toString() => "r: $r, g: $g, b: $b";

  String toHexString() {
    Map<String, String> hexMap = this.toHexMap();
    return "${hexMap['r']}${hexMap['g']}${hexMap['b']}";
  }

  Map<String, String> toHexMap() {
    return {
      'r': _r.toRadixString(16),
      'g': _g.toRadixString(16),
      'b': _b.toRadixString(16)
    };
  }
}