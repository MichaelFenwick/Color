part of color;

class ColorParser {
  static final RegExp _beginsHash = new RegExp("^#");

  // HEX
  // Matches unabbreviated hex code with length of either 6 (no alpha) or
  // 8 (alpha).
  static final RegExp _hexColorRegExp =
  new RegExp("^#?(?=[\\da-fA-F]*\$)(?:.{8}|.{6})\$");

  // Matches abbreviated hex code with length of either 3 (no alpha) or
  // 4 (alpha).
  static final RegExp _hexColorAbbreviatedRegExp =
  new RegExp("^#?(?=[\\da-fA-F]*\$)(?:.{3}|.{4})\$");

  // RGB
  // Matches a rgb color string without rgb(...) frame.
  static final RegExp _rgbColorImplicitRegExp =
  new RegExp("^(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\$");

  // Matches a rgb color string with rgb(...) frame.
  static final RegExp _rgbColorExplicitRegExp = new RegExp(
      "^rgb\\(\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*\\)\$");

  // RGBA
  // Matches a rgba color string without rgba(...) frame.
  static final _rgbaColorImplicitRegExp = new RegExp(
      "^\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*((1)|(1\\.0)|0?(\\.\\d{1,2})?)\\s*\$");

  // Matches a rgba color string with rgba(...) frame.
  static final _rgbaColorExplicitRegExp = new RegExp(
      "^rgba\\(\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*(\\d{1,3})\\s*,\\s*((1)|(1\\.0)|0?(\\.\\d{1,2})?)\\s*\\)\$");

  // HSL
  // Matches a hsl color string.
  static final RegExp _hslColorRegExp = new RegExp(
      "^hsl\\(\\s*(\\d{1,3})\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*\\)\$");

  // HSLA
  // Matches a hsla color string.
  static final RegExp _hslaColorRegExp = new RegExp(
      "^hsla\\(\\s*(\\d{1,3})\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*,\\s*(\\d+(\\.\\d*)?|\\.\\d+)%\\s*,\\s*((1)|(1\\.0)|0?(\\.\\d{1,2})?)\\s*\\)\$");

  Color parse(String toParse, {Color orElse()}) {
    toParse = toParse.trim();
    return _parseRgb(toParse) ??
        _parseRgba(toParse) ??
        _parseHex(toParse) ??
        _parseHsl(toParse) ??
        _parseHsla(toParse) ??
        _parseNamed(toParse) ??
        orElse?.call() ??
        null;
  }

  Color _parseHex(String toParse) {
    if (_hexColorRegExp.hasMatch(toParse)) {
      return new HexColor(toParse);
    }

    // Convert abbreviated hex to not abbreviated hex
    if (_hexColorAbbreviatedRegExp.hasMatch(toParse)) {
      String _unAbbreviated = new String.fromCharCodes(toParse
          .replaceFirst(_beginsHash, "")
          .codeUnits
          .map((c) => [c, c])
          .expand((c) => c));
      return new HexColor(_unAbbreviated);
    }

    return null;
  }

  Color _parseHsl(String toParse) {
    if (_hslColorRegExp.hasMatch(toParse)) {
      Match match = _hslColorRegExp.allMatches(toParse).first;
      return new HslColor(
          int.parse(match.group(1)),
          double.parse(match.group(2) ?? match.group(3)),
          double.parse(match.group(4) ?? match.group(5)));
    }

    return null;
  }

  Color _parseRgb(String toParse) {
    if (_rgbColorImplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorImplicitRegExp.allMatches(toParse).first;
      return new RgbColor(int.parse(match.group(1)), int.parse(match.group(2)),
          int.parse(match.group(3)));
    }

    if (_rgbColorExplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbColorExplicitRegExp.allMatches(toParse).first;
      return new RgbColor(int.parse(match.group(1)), int.parse(match.group(2)),
          int.parse(match.group(3)));
    }

    return null;
  }

  Color _parseRgba(String toParse) {
    if (_rgbaColorImplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbaColorImplicitRegExp
          .allMatches(toParse)
          .first;
      return new RgbaColor(int.parse(match.group(1)), int.parse(match.group(2)),
          int.parse(match.group(3)), double.parse(match.group(4)));
    }

    if (_rgbaColorExplicitRegExp.hasMatch(toParse)) {
      Match match = _rgbaColorExplicitRegExp
          .allMatches(toParse)
          .first;
      return new RgbaColor(int.parse(match.group(1)), int.parse(match.group(2)),
          int.parse(match.group(3)), double.parse(match.group(4)));
    }

    return null;
  }

  Color _parseHsla(String toParse) {
    if (_hslaColorRegExp.hasMatch(toParse)) {
      Match match = _hslaColorRegExp
          .allMatches(toParse)
          .first;
      return new HslaColor(
          int.parse(match.group(1)),
          double.parse(match.group(2) ?? match.group(3)),
          double.parse(match.group(4) ?? match.group(5)),
          double.parse(match.group(6)));
    }

    return null;
  }

  Color _parseNamed(String toParse) {
    try {
      return new RgbColor.name(toParse.toLowerCase());
    } catch (argumentError) {
      return null;
    }
  }
}
