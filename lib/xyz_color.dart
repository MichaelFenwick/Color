part of color;

class XyzColor extends Color {

  num _x;
  num _y;
  num _z;

  XyzColor(num x, num y, num z) {
    _x = x;
    _y = y;
    _z = z;
  }

  XyzColor.referenceWhite() {
    _x = 95.047;
    _y = 100;
    _z = 108.883;
  }

  get x => _x;
  get y => _y;
  get z => _z;

  set x(num x) => _x = x;
  set y(num y) => _y = y;
  set z(num z) => _z = z;

  RgbColor toRgbColor() {
    num x = _x / 100;
    num y = _y / 100;
    num z = _z / 100;

    Map<String, num> rgb = {
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
      rgb[key] *= 255;
    });

    return new RgbColor(rgb['r'], rgb['g'], rgb['b']);
  }

  CielabColor toCielabColor() {
    Map<String, num> lab = {};
    Map<String, num> xyz = {};
    XyzColor referenceWhite = new XyzColor.referenceWhite();

    this.toMap().forEach((String key, num value) {
      value /= referenceWhite[key];

      if (value > 0.008856) {
        value = pow(value, 1/3);
      } else {
        value = (7.787 * value) + 16 / 116;
      }
      xyz[key] = value;
    });

    lab['l'] = (116 * xyz['y']) - 16;
    lab['a'] = 500 * (xyz['x'] - xyz['y']);
    lab['b'] = 200 * (xyz['y'] - xyz['z']);

    return new CielabColor(lab['l'], lab['a'], lab['b']);
  }

  String toString() => "x: $x, y: $y, z: $z";

  Map<String, num> toMap() => {'x': x, 'y': y, 'z': z};

}
