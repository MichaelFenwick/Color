import 'dart:html';

import 'package:color/color.dart';

Element body = querySelector('body');

void main() {
  addGrid('Normal');
  addGrid('Sepia', ColorFilter.sepia);
  addGrid('Greyscale', ColorFilter.greyscale);
  addGrid('Inverted', ColorFilter.invert);
  addGrid('Lightened (20%)', ColorFilter.lighten, [.2]);
  addGrid('Darkened (20%)', ColorFilter.darken, [.2]);
}

void addGrid(String name, [ColorFilter filter, List<num> filterArgs = const []]) {
  body.appendText(name);
  var grid = Element.div()..classes.add('grid');
  body.append(grid);
  num step = 15.9375;
  for (num l = 0; l <= 100; l += step * 100 / 255) {
    var block = Element.div()..classes.add('block');
    grid.append(block);
    for (num a = -128; a <= 127; a += step) {
      for (num b = -128; b <= 127; b += step) {
        var color = CielabColor(l, a, b);
        if (filter != null) {
          color = filter(color, filterArgs) as CielabColor;
        }
        block.append(Element.div()
          ..classes.add('color-block')
          ..style.background = color.toRgbColor().toCssString());
      }
    }
  }
}
