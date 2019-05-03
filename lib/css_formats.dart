import 'package:color/color.dart';

abstract class CssColorFormat {
  String format(Color color);
}

abstract class _RgbFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final PercentOrDecimal rgbStyle;
  final PercentOrDecimal opacityStyle;

  String get prefix;

  _RgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTranslucent,
        this.rgbStyle = rgbStyle ?? PercentOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent;

  String format(Color color) {
    final rgbColor = color.toRgb();
    final stringBuffer = StringBuffer();
    stringBuffer
        .write('$prefix(${rgbColor.red}, ${rgbColor.green}, ${rgbColor.blue}');
    if (opacityMode == OpacityMode.always ||
        opacityMode == OpacityMode.whenTranslucent &&
            color.opacity == Color.maxOpacity) {
      stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
    }
    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}

class RgbFormat extends _RgbFormat implements CssColorFormat {
  @override
  final prefix = 'rgb';

  RgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : super(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle);
}

class RgbaFormat extends _RgbFormat implements CssColorFormat {
  @override
  final prefix = 'rgba';

  RgbaFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : super(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle);
}

abstract class _HslFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final DegreeOrDecimal hueStyle;
  final PercentOrDecimal opacityStyle;

  String get prefix;

  _HslFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTranslucent,
        this.hueStyle = hueStyle ?? DegreeOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent;

  String format(Color color) {
    final hslColor = color.toHsl();
    final stringBuffer = StringBuffer();

    final hue = _formatHue(hueStyle, hslColor.hue);
    final saturation = '${hslColor.saturation}%';
    final lightness = '${hslColor.lightness}%';

    stringBuffer.write('$prefix($hue, $saturation, $lightness');
    if (opacityMode == OpacityMode.always ||
        opacityMode == OpacityMode.whenTranslucent &&
            color.opacity == Color.maxOpacity) {
      if (opacityMode == OpacityMode.always ||
          opacityMode == OpacityMode.whenTranslucent &&
              color.opacity == Color.maxOpacity) {
        stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
      }
    }
    stringBuffer.write(')');

    return stringBuffer.toString();
  }
}

class HslFormat extends _HslFormat {
  final prefix = "hsl";

  HslFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : super(
            opacityMode: opacityMode,
            hueStyle: hueStyle,
            opacityStyle: opacityStyle);
}

class HslaFormat extends _HslFormat {
  final prefix = "hsla";

  HslaFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : super(
            opacityMode: opacityMode,
            hueStyle: hueStyle,
            opacityStyle: opacityStyle);
}

// -----
// Utils
// -----

String _formatOpacity(PercentOrDecimal style, num value) =>
    style == PercentOrDecimal.decimal ? '${value}' : '${value * 100}';

String _formatHue(DegreeOrDecimal style, num value) =>
    style == DegreeOrDecimal.degree ? '${value}' : '${value}deg';

enum PercentOrDecimal { percent, decimal }

enum DegreeOrDecimal { degree, decimal }

enum OpacityMode { always, never, whenTranslucent }
