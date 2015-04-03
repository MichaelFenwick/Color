import 'dart:html';
import 'package:color/color.dart';

Element body = querySelector('body');

main() {
  addGrid('Normal');
  addGrid('Sepia', ColorFilter.sepia);
  addGrid('Greyscale', ColorFilter.greyscale);
  addGrid('Inverted', ColorFilter.invert);
}

addGrid(String name, [ColorFilter filter, List filterArgs = const []]) {
  body.appendText(name);
  Element grid = new Element.div()..classes.add('grid');
  body.append(grid);
  for (int r = 0; r <= 255; r += 31.875) {
    for (int g = 0; g <= 255; g += 31.875) {
      for (int b = 0; b <= 255; b += 31.875) {
        RgbColor rgb = new RgbColor(r, g, b);
        if (filter != null) {
          rgb = filter(rgb, filterArgs);
        }
        grid.append(new Element.div()
          ..classes.add('color-block')
          ..style.background = rgb.toCssString());
      }
    }
  }
}
