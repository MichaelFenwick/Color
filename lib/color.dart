import 'dart:math';

class Color {
  int _r;
  int _g;
  int _b;

  Color() {}

  Color.rgb(int r, int g, int b) {
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

  Color.hsl(num hue, num saturation, num luminance) {
    List<num> rgb = [0, 0, 0];

    hue = hue / 360 % 1;
    saturation /= 100;
    luminance /= 100;

    if (hue < 1 / 6) {
      rgb[0] = 1;
      rgb[1] = hue * 6;
    } else if (hue < 2 / 6) {
      rgb[0] = 2 - hue * 6;
      rgb[1] = 1;
    } else if (hue < 3 / 6) {
      rgb[1] = 1;
      rgb[2] = hue * 6 - 2;
    } else if (hue < 4 / 6) {
      rgb[1] = 4 - hue * 6;
      rgb[2] = 1;
    } else if (hue < 5 / 6) {
      rgb[0] = hue * 6 - 4;
      rgb[2] = 1;
    } else {
      rgb[0] = 1;
      rgb[2] = 6 - hue * 6;
    }

    rgb = rgb.map((val) => val + (1 - saturation) * (0.5 - val));

    if (luminance < 0.5) {
      rgb = rgb.map((val) => luminance * 2 * val);
    } else {
      rgb = rgb.map((val) => luminance * 2 * (1 - val) + 2 * val - 1);
    }

    rgb = rgb.map((val) => (val * 255).round());

    rgb = rgb.toList();

    this.r = rgb[0];
    this.g = rgb[1];
    this.b = rgb[2];
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