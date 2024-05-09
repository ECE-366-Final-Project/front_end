import 'package:front_end/color-palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

    test('smoke test color-palette', () {
      final palette = ColorPalette();
      expect(palette.value, 0xFF000000);
    });

}