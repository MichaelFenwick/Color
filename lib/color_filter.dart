part of color;

typedef Color FilterFunction(Color color, [List args]);

class ColorFilter {
  final FilterFunction filterFunction;
  final Type baseType;

  ColorFilter(FilterFunction this.filterFunction, Type this.baseType);

  static ColorFilter sepia = new ColorFilter((RgbColor color, [List args]) {
    return new RgbColor(min(RgbColor.rMax,
        (color.r * 0.393 + color.g * 0.769 + color.b * 0.189)), min(
        RgbColor.gMax,
        (color.r * 0.349 + color.g * 0.686 + color.b * 0.168)), min(
        RgbColor.bMax, (color.r * 0.272 + color.g * 0.534 + color.b * 0.131)));
  }, RgbColor);

  static ColorFilter greyscale = new ColorFilter((RgbColor color, [List args]) {
    XyzColor xyz = color.toXyzColor();
    return new RgbColor(RgbColor.rMax / 100 * xyz.y,
        RgbColor.gMax / 100 * xyz.y, RgbColor.bMax / 100 * xyz.y);
  }, RgbColor);

  static ColorFilter invert = new ColorFilter((RgbColor color, [List args]) {
    return new RgbColor(RgbColor.rMax - color.r, RgbColor.gMax - color.g,
        RgbColor.bMax - color.b);
  }, RgbColor);

  Color call(Color color, List args) {
    Type startingColorSpace = color.runtimeType;
    color = color._convert(this.baseType);
    color = this.filterFunction(color, args);
    color = color._convert(startingColorSpace);
    return color;
  }
}
