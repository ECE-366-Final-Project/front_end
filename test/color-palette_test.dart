import 'package:flutter/material.dart';
import 'package:front_end/color-palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('smoke test color-palette', () {
    final palette = ColorPalette();
    expect(palette.value, 0xFF000000);
  });

  test('Test ColorPalette resolve', () {
    // Create a ColorPalette instance
    final colorPalette = ColorPalette();

    // Test default color
    expect(colorPalette.resolve({}), equals(const Color(0xFF000000)));

    // Test pressed state color
    expect(
        colorPalette.resolve({MaterialState.pressed}),
        equals(const Color(
            0xFF000000))); // Change this to the expected pressed color if it's different
  });
}
