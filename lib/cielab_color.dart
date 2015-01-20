part of color;

class CielabColor extends Color {

  num _l;
  num _a;
  num _b;

  CielabColor(num l, num a, num b) {
    _l = l;
    _a = a;
    _b = b;
  }

  get l => _l;
  get a => _a;
  get b => _b;

  set l(num l) => _l = l;
  set a(num a) => _a = a;
  set b(num b) => _b = b;

  RgbColor toRgbColor() {
    XyzColor xyz = toXyzColor();
    return xyz.toRgbColor();
  }

  XyzColor toXyzColor() {
    Map<String, num> xyz = {
      'x': _a / 500 + (_l + 16) / 116,
      'y': (_l + 16) / 116,
      'z': (_l + 16) / 116 - _b / 200
    };

    XyzColor referenceWhite = new XyzColor.referenceWhite();

    xyz.forEach((key, value) {
      num cube = pow(value, 3);
      if (cube > 0.008856) {
        xyz[key] = cube;
      } else {
        xyz[key] = (value - 16 / 116) / 7.787;
      }
      xyz[key] *= referenceWhite[key];
    });

    return new XyzColor(xyz['x'], xyz['y'], xyz['z']);
  }

  String toString() => "l: $l, a: $a, b: $b";

  Map<String, num> toMap() => {'l': l, 'a': a, 'b': b};

}
