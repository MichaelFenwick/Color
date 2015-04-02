import 'dart:html';
import 'package:color/color.dart';

Element body = querySelector('body');

main() {
  addGrid();
}

addGrid() {
  Element grid = new Element.div()
    ..classes.add('grid');
  body.append(grid);
  for (int r = 0; r <= 255; r += 31.875) {
    for (int g = 0; g <= 255; g += 31.875) {
      for (int b = 0; b <= 255; b += 31.875) {
        RgbColor rgb = new RgbColor(r, g, b);
        grid.append(new Element.div()
                      ..classes.add('color-block')
                      ..style.background = rgb.toCssString());

      }
    }
  }
}
