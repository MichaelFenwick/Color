part of color;

class ColorParser {
  static final RegExp _beginsHash = RegExp('^#');
  static final RegExp _hexColorRegExp = RegExp(r'^#?([\da-fA-F]{6})$');
  static final RegExp _hexColorAbbreviatedRegExp = RegExp(r'^#?([\da-fA-F]{3})$');
  static final RegExp _rgbColorImplicitRegExp = RegExp(r'^(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})$');
  static final RegExp _rgbColorExplicitRegExp = RegExp(r'^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$');
  static final RegExp _hslColorRegExp = RegExp(r'^hsl\(\s*(\d{1,3})\s*,\s*(\d+(\.\d*)?|\.\d+)%\s*,\s*(\d+(\.\d*)?|\.\d+)%\s*\)$');

  Color parse(String toParse, {Color Function() orElse}) {
    toParse = toParse.trim();
    return _parseRgb(toParse) ?? _parseHex(toParse) ?? _parseHsl(toParse) ?? _parseNamed(toParse) ?? orElse?.call();
  }

  Color _parseHex(String toParse) {
    if (_hexColorRegExp.hasMatch(toParse)) {
      return HexColor(toParse);
    }

    if (_hexColorAbbreviatedRegExp.hasMatch(toParse)) {
      var _unAbbreviated = String.fromCharCodes(toParse.replaceFirst(_beginsHash, '').codeUnits.map((c) => [c, c]).expand((c) => c));
      return HexColor(_unAbbreviated);
    }

    return null;
  }

  Color _parseHsl(String toParse) {
    if (_hslColorRegExp.hasMatch(toParse)) {
      Match match = _hslColorRegExp.allMatches(toParse).first;
      return HslColor(int.parse(match.group(1)), double.parse(match.group(2) ?? match.group(3)), double.parse(match.group(4) ?? match.group(5)));
    }

    return null;
  }

  Color _parseRgb(String toParse) {
    if (_rgbColorImplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorImplicitRegExp.allMatches(toParse).first;
      return RgbColor(int.parse(match.group(1)), int.parse(match.group(2)), int.parse(match.group(3)));
    }

    if (_rgbColorExplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorExplicitRegExp.allMatches(toParse).first;
      return RgbColor(int.parse(match.group(1)), int.parse(match.group(2)), int.parse(match.group(3)));
    }

    return null;
  }

  Color _parseNamed(String toParse) {
    try {
      return RgbColor.name(toParse.toLowerCase());
    } catch (argumentError) {
      return null;
    }
  }
}
