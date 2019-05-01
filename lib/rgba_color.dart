part of color;

class RgbaColor extends RgbColor {
  int get alpha => value & 0xFF0000;

  const RgbaColor(int value) : super(value);

  const RgbaColor.fromRgba(int red, int green, int blue, int alpha)
      : super((((alpha & 0xff) << 24) |
            ((red & 0xff) << 16) |
            ((green & 0xff) << 8) |
            ((blue & 0xff) << 0)));

  String toString() => 'rgba(${red}, ${green}, ${blue}, ${alpha})';

  @override
  Color withAlpha(int alpha) => RgbaColor.fromRgba(red, green, blue, alpha);
}
