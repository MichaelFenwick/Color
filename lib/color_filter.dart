part of color;

typedef Color FilterFunction(Color color, [List args]);

class ColorFilter {

  final FilterFunction filterFunction;
  final Type baseType;

  ColorFilter(FilterFunction this.filterFunction, Type this.baseType);

  /**
   * Makes the color lighter by the percentage specified in the first argument, or by 10% if no percentage is specified. Percentages should be specified as a float, e.g. an argument of 0.25 will result in a color 25% lighter than the original. The lightening conversion is performed by adjusting the y component of the color in XYZ color space.
   */
  static ColorFilter lighten = new ColorFilter((XyzColor color, [List args]) {
    num percent = 0.1;
    if (args is List && args.length > 0 && args[0] is num) {
      percent = args[0];
    }
    color.y *= 1 + percent;
    return color.clone();
  }, XyzColor);


  /**
   * Makes the color darker by the percentage specified in the first argument, or by 10% if no percentage is specified. Percentages should be specified as a float, e.g. an argument of 0.25 will result in a color 25% darker than the original. The darkening conversion is performed by adjusting the y component of the color in XYZ color space.
   */
  static ColorFilter darken = new ColorFilter((XyzColor color, [List args]) {
    num percent = 0.1;
    if (args is List && args.length > 0 && args[0] is num) {
      percent = args[0];
    }
    color.y *= 1 - percent;
  }, XyzColor);

  /**
   *
   */
  static ColorFilter sepia = new ColorFilter((RgbColor color, [List args]) {
    color = new RgbColor(
      min(255, (color.r * 0.393 + color.g * 0.769 + color.b * 0.189)),
      min(255, (color.r * 0.349 + color.g * 0.686 + color.b * 0.168)),
      min(255, (color.r * 0.272 + color.g * 0.534 + color.b * 0.131))
    );
  }, RgbColor);

  /**
   *
   */
  static ColorFilter greyscale = new ColorFilter((RgbColor color, [List args]) {
    XyzColor xyz = color.toXyzColor();
    color = new RgbColor(xyz.y, xyz.y, xyz.y);
  }, RgbColor);


  Color call(Color color, List args) {
    Type startingColorSpace = color.runtimeType;
    color = _convert(color, this.baseType);
    this.filterFunction(color, args);
    color = _convert(color, startingColorSpace);
    return color;
  }

  static Color _convert(Color color, Type colorType) {
    switch (colorType) {
      case RgbColor:
        return color.toRgbColor();
      case HslColor:
        return color.toHslColor();
      case XyzColor:
        return color.toXyzColor();
      case CielabColor:
        return color.toCielabColor();
    }
  }

}
