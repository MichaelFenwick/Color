part of color;

class XyzColor extends Color {
  final num x;
  final num y;
  final num z;

  static const referenceWhite = XyzColor(95.047, 100, 108.883);

  const XyzColor(this.x, this.y, this.z);

  @override
  RgbColor toRgbColor() {
    num x = this.x / 100;
    num y = this.y / 100;
    num z = this.z / 100;

    var rgb = <String, num>{
      'r': x * 3.2406 + y * -1.5372 + z * -0.4986,
      'g': x * -0.9689 + y * 1.8758 + z * 0.0415,
      'b': x * 0.0557 + y * -0.2040 + z * 1.0570
    };

    rgb.forEach((key, value) {
      if (value > 0.0031308) {
        rgb[key] = 1.055 * pow(value, 1 / 2.4) - 0.055;
      } else {
        rgb[key] = value * 12.92;
      }
      rgb[key] = rgb[key]! * 255;
    });

    return RgbColor(rgb['r']!, rgb['g']!, rgb['b']!);
  }

  @override
  HslColor toHslColor() => toRgbColor().toHslColor();

  @override
  HsvColor toHsvColor() => toRgbColor().toHsvColor();

  @override
  XyzColor toXyzColor() => this;

  @override
  CielabColor toCielabColor() {
    var lab = <String, num>{};
    var xyz = <String, num>{};

    toMap().forEach((String key, num value) {
      value /= referenceWhite[key];

      if (value > 0.008856) {
        value = pow(value, 1 / 3);
      } else {
        value = (7.787 * value) + 16 / 116;
      }
      xyz[key] = value;
    });

    lab['l'] = (116 * xyz['y']!) - 16;
    lab['a'] = 500 * (xyz['x']! - xyz['y']!);
    lab['b'] = 200 * (xyz['y']! - xyz['z']!);

    return CielabColor(lab['l']!, lab['a']!, lab['b']!);
  }

  @override
  String toString() => 'x: $x, y: $y, z: $z';

  @override
  Map<String, num> toMap() => {'x': x, 'y': y, 'z': z};
}
