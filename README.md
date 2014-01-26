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
```

Alternatively, a color can be created from a string containing a hex value with

```dart
Color hexColor = new Color.hex('c0ffee');
```

Regardless of how a color is constructed, its value is internally stored as rgb values and is accessed the same as any other color.

Colors can be compared using the `==` operator, which will evaluate to true if the two colors share identical rgb values.

```dart
assert(new Color.hex('c0ffee') == new Color.hex('c0ffee'));
```
