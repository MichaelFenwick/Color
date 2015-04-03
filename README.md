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

Alternatively, a color can be created from a string containing a hex value with

```dart
Color hexColor = new Color.hex('c0ffee');
```

Colors can be compared using the `==` operator, which will evaluate to true if the two colors share identical rgb values.

```dart
assert(new Color.hex('c0ffee') == new Color.hex('c0ffee'));
```

Colors can be converted from one color space to another by calling the appropriate `toXXXColor` method on them.

```dart
HslColor hsl = new RgbColor(192, 255, 238).toHslColor();
```

Colors can be altered using a ColorFilter, which will return a new color in the same color space as the input color with that filter 
applied to it.

```dart
RgbColor grey = ColorFilter.greyscale(new RgbColor(192, 255, 238));
HslColor sepia = ColorFilter.sepia(new HslColor(163.8, 100, 87.6));
```
