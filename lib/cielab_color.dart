part of color;

class CielabColor extends Color {
  final num l;
  final num a;
  final num b;

  const CielabColor(this.l, this.a, this.b);

  @override
  RgbColor toRgbColor() {
    var xyz = toXyzColor();
    return xyz.toRgbColor();
  }

  @override
  HslColor toHslColor() => toRgbColor().toHslColor();

  @override
  HsvColor toHsvColor() => toRgbColor().toHsvColor();

  @override
  XyzColor toXyzColor() {
    var xyz = <String, num>{'x': a / 500 + (l + 16) / 116, 'y': (l + 16) / 116, 'z': (l + 16) / 116 - b / 200};

    xyz.forEach((key, value) {
      var cube = pow(value, 3);
      if (cube > 0.008856) {
        xyz[key] = cube;
      } else {
        xyz[key] = (value - 16 / 116) / 7.787;
      }
      xyz[key] = xyz[key]! * XyzColor.referenceWhite[key];
    });

    return XyzColor(xyz['x']!, xyz['y']!, xyz['z']!);
  }

  @override
  CielabColor toCielabColor() => this;

  @override
  String toString() => 'l: $l, a: $a, b: $b';

  @override
  Map<String, num> toMap() => {'l': l, 'a': a, 'b': b};
}
