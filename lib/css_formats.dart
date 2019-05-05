import 'package:color/color.dart';
import 'package:color/rgb_color.dart';
import 'package:meta/meta.dart';

abstract class CssColorFormat {
  String format(Color color);
}

class _RgbFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final PercentOrDecimal rgbStyle;
  final PercentOrDecimal opacityStyle;
  final String prefix;

  _RgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle,
      @required String prefix})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTranslucent,
        this.rgbStyle = rgbStyle ?? PercentOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent,
        this.prefix = prefix;

  String format(Color color) {
    final rgbColor = color.toRgb();
    final stringBuffer = StringBuffer();
    stringBuffer
        .write('$prefix(${rgbColor.red}, ${rgbColor.green}, ${rgbColor.blue}');
    if (_shouldIncludeOpacity(opacityMode, color.isTransparent)) {
      stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
    }
    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}

class RgbFormat implements CssColorFormat {
  final _RgbFormat _format;

  RgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : _format = _RgbFormat(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle,
            prefix: 'rgb');

  @override
  String format(Color color) => _format.format(color);
}

class RgbaFormat implements CssColorFormat {
  final _RgbFormat _format;

  RgbaFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : _format = _RgbFormat(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle,
            prefix: 'rgba');
}

class _HslFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final DegreeOrDecimal hueStyle;
  final PercentOrDecimal opacityStyle;
  final String prefix;

  _HslFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle,
      @required String prefix})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTranslucent,
        this.hueStyle = hueStyle ?? DegreeOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent,
        this.prefix = prefix;

  String format(Color color) {
    final hslColor = color.toHsl();
    final stringBuffer = StringBuffer();

    final hue = _formatHue(hueStyle, hslColor.hue);
    final saturation = '${hslColor.saturation}%';
    final lightness = '${hslColor.lightness}%';

    stringBuffer.write('$prefix($hue, $saturation, $lightness');
    if (_shouldIncludeOpacity(opacityMode, color.isTransparent)) {
      stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
    }
    stringBuffer.write(')');

    return stringBuffer.toString();
  }
}

class HslFormat implements CssColorFormat {
  final _HslFormat _format;

  HslFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : _format = _HslFormat(
            opacityMode: opacityMode,
            hueStyle: hueStyle,
            opacityStyle: opacityStyle,
            prefix: 'hsl');

  @override
  String format(Color color) => _format.format(color);
}

class HslaFormat implements CssColorFormat {
  final _HslFormat _format;

  HslaFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : _format = _HslFormat(
            opacityMode: opacityMode,
            hueStyle: hueStyle,
            opacityStyle: opacityStyle,
            prefix: 'hsla');

  @override
  String format(Color color) => _format.format(color);
}

class HexFormat implements CssColorFormat {
  final bool isUpperCase;
  final OpacityMode opacityMode;

  HexFormat({bool isUpperCase, bool isCompact, OpacityMode opacityMode})
      : this.isUpperCase = isUpperCase ?? true,
        this.opacityMode = opacityMode ?? OpacityMode.whenTranslucent;

  @override
  String format(Color color) {
    final rgbColor = color.toRgb();
    final rgbHex = (rgbColor.value & 0xFFFFFF).toRadixString(16);

    final stringBuffer = StringBuffer();
    stringBuffer.write("#$rgbHex");
    if (_shouldIncludeOpacity(opacityMode, rgbColor.isTransparent)) {
      final alphaHex = rgbColor.alpha == RgbColor.minAlpha
          ? "00"
          : rgbColor.alpha.toRadixString(16);
      stringBuffer.write(alphaHex);
    }

    final hex = stringBuffer.toString();

    return isUpperCase ? hex.toUpperCase() : hex.toLowerCase();
  }
}

// -----
// Utils
// -----

String _formatOpacity(PercentOrDecimal style, num value) =>
    style == PercentOrDecimal.decimal ? '${value}' : '${value * 100}';

String _formatHue(DegreeOrDecimal style, num value) =>
    style == DegreeOrDecimal.degree ? '${value}' : '${value}deg';

bool _shouldIncludeOpacity(OpacityMode opacityMode, bool isTranslucent) =>
    opacityMode == OpacityMode.always ||
    opacityMode == OpacityMode.whenTranslucent && isTranslucent;

enum PercentOrDecimal { percent, decimal }

enum DegreeOrDecimal { degree, decimal }

enum OpacityMode { always, never, whenTranslucent }
