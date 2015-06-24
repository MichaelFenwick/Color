Color
=====
A simple Dart package exposing a Color class which can be used to create, convert, and compare colors.

Installation
-----
1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  color: any
```

1. Get the package using your IDE's GUI or via command line with

```bash
$ pub get
```

1. Import the `color.dart` file in your app

```dart
import 'package:color/color.dart';
```

Usage
-----
Color objects can be constructed using any of a few available constructors.

To create a color from rgb values, call

```dart
Color rgbColor = new Color.rgb(192, 255, 238);
RgbColor rgbColor = new RgbColor(192, 255, 238);
```

Alternatively, a color can be created directly in a number of other color spaces.

```dart
RgbColor rgb = new RgbColor(192, 255, 238);
HexColor hex = new HexColor('c0ffee');
HslColor hsl = new HslColor(163.8, 100, 87.6);
XyzColor xyz = new XyzColor(72.931, 88.9, 94.204);
CielabColor cielab = new CielabColor(95.538, -23.02, 1.732);
```

Colors are immutable, and can be created using const constructors.

```dart
RgbColor rgb = const RgbColor(192, 255, 238);
```

Colors can be created directly from CSS3 color names.

```dart
RgbColor black = new RgbColor.name('black'); //factory constructor that returns a const RgbColor
RgbColor white = RgbColor.namedColors['black']; //directly reference the const RgbColor without the factory
```

Colors implementing the CssColorSpace interface can output a css string representation.

```dart
RgbColor rgb = new RgbColor(192, 255, 238);
HexColor hex = new HexColor('c0ffee');
HslColor hsl = new HslColor(163.8, 100, 87.6);
assert(rgb is CssColorSpace, true);
assert(hex is CssColorSpace, true);
assert(hsl is CssColorSpace, true);
print(rgb.toCssString()); //rgb(192, 255, 238)
print(hex.toCssString()); //#c0ffee
print(hsl.toCssString()); //hsl(163.8, 100.0%, 87.6%)
```

Colors can be compared using the `==` operator, which will evaluate to true if the two colors share identical rgb values after being rounded to integers.

```dart
assert(new Color.hex('c0ffee') == new Color.hex('c0ffee'));
assert(new Color.rgb('192, 255, 238') == new Color.hex('c0ffee'));
```

Colors can be converted from one color space to another by calling the appropriate `toXXXColor` method on them.

```dart
HslColor hsl = new RgbColor(192, 255, 238).toHslColor();
```

Colors can be altered using a ColorFilter, which will return a new color in the same color space as the input color with that filter applied to it.

```dart
RgbColor grey = ColorFilter.greyscale(new RgbColor(192, 255, 238));
HslColor sepia = ColorFilter.sepia(new HslColor(163.8, 100, 87.6));
```
