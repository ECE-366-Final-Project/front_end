import 'package:flutter/material.dart';

class ColorPalette extends MaterialStateColor {
  const ColorPalette() : super(_defaultColor);

  static const int _defaultColor = 0xFF000000;
  static const int _pressedColor = 0xFF000000;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
