import 'package:color/color.dart';
import 'package:color/rgb_color.dart';
import 'package:meta/meta.dart';

abstract class CssColorFormat {
  String format(Color color);
}

class PrefixRgbFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final PercentOrDecimal rgbStyle;
  final PercentOrDecimal opacityStyle;
  final String prefix;

  PrefixRgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle,
      @required String prefix})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTransparent,
        this.rgbStyle = rgbStyle ?? PercentOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent,
        this.prefix = prefix;

  String format(Color color) {
    final rgbColor = color.toRgb();
    final stringBuffer = StringBuffer();

    String rgbPart(String red, String green, String blue) =>
        '$prefix($red, $green, $blue';

    if (rgbStyle == PercentOrDecimal.decimal) {
      stringBuffer.write(rgbPart(rgbColor.red.toString(),
          rgbColor.green.toString(), rgbColor.blue.toString()));
    } else {
      final redAsPercent = _fractionalAsPercent(rgbColor.red / 255);
      final greenAsPercent = _fractionalAsPercent(rgbColor.green / 255);
      final blueAsPercent = _fractionalAsPercent(rgbColor.blue / 255);
      stringBuffer.write(rgbPart(redAsPercent, greenAsPercent, blueAsPercent));
    }
    if (_shouldIncludeOpacity(opacityMode, color.isTransparent)) {
      stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
    }
    stringBuffer.write(')');
    return stringBuffer.toString();
  }
}

class RgbFormat implements CssColorFormat {
  final PrefixRgbFormat _format;

  RgbFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : _format = PrefixRgbFormat(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle,
            prefix: 'rgb');

  @override
  String format(Color color) => _format.format(color);
}

class RgbaFormat implements CssColorFormat {
  final PrefixRgbFormat _format;

  RgbaFormat(
      {OpacityMode opacityMode,
      PercentOrDecimal rgbStyle,
      PercentOrDecimal opacityStyle})
      : _format = PrefixRgbFormat(
            opacityMode: opacityMode,
            rgbStyle: rgbStyle,
            opacityStyle: opacityStyle,
            prefix: 'rgba');

  @override
  String format(Color color) => _format.format(color);
}

class PrefixHslFormat implements CssColorFormat {
  final OpacityMode opacityMode;
  final DegreeOrDecimal hueStyle;
  final PercentOrDecimal opacityStyle;
  final String prefix;

  PrefixHslFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle,
      @required String prefix})
      : this.opacityMode = opacityMode ?? OpacityMode.whenTransparent,
        this.hueStyle = hueStyle ?? DegreeOrDecimal.decimal,
        this.opacityStyle = opacityStyle ?? PercentOrDecimal.percent,
        this.prefix = prefix;

  String format(Color color) {
    final hslColor = color.toHsl();
    final stringBuffer = StringBuffer();

    final hue = _formatHue(hueStyle, hslColor.hue);
    final saturation = '${_decimalAsPercent(hslColor.saturation)}';
    final lightness = '${_decimalAsPercent(hslColor.lightness)}';

    stringBuffer.write('$prefix($hue, $saturation, $lightness');
    if (_shouldIncludeOpacity(opacityMode, color.isTransparent)) {
      stringBuffer.write(', ${_formatOpacity(opacityStyle, color.opacity)}');
    }
    stringBuffer.write(')');

    return stringBuffer.toString();
  }
}

class HslFormat implements CssColorFormat {
  final PrefixHslFormat _format;

  HslFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : _format = PrefixHslFormat(
            opacityMode: opacityMode,
            hueStyle: hueStyle,
            opacityStyle: opacityStyle,
            prefix: 'hsl');

  @override
  String format(Color color) => _format.format(color);
}

class HslaFormat implements CssColorFormat {
  final PrefixHslFormat _format;

  HslaFormat(
      {OpacityMode opacityMode,
      DegreeOrDecimal hueStyle,
      PercentOrDecimal opacityStyle})
      : _format = PrefixHslFormat(
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
        this.opacityMode = opacityMode ?? OpacityMode.whenTransparent;

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

String _formatOpacity(PercentOrDecimal style, num value) {
  if (style == PercentOrDecimal.decimal) {
    return value.toStringAsFixed(2);
  }
  return _fractionalAsPercent(value);
}

String _decimalAsPercent(num decimal) {
  final asString =
      (decimal % 1) == 0 ? decimal.toInt() : decimal.toStringAsFixed(2);
  return '$asString%';
}

String _fractionalAsPercent(num fractional) =>
    _decimalAsPercent(fractional * 100);

String _formatHue(DegreeOrDecimal style, num value) =>
    style == DegreeOrDecimal.degree ? '${value}deg' : '${value}';

bool _shouldIncludeOpacity(OpacityMode opacityMode, bool isTranslucent) =>
    opacityMode == OpacityMode.always ||
    opacityMode == OpacityMode.whenTransparent && isTranslucent;

enum PercentOrDecimal { percent, decimal }

enum DegreeOrDecimal { degree, decimal }

enum OpacityMode { always, never, whenTransparent }
