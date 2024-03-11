import 'package:flutter/material.dart';

class DWPalette extends MaterialStateColor {
  const DWPalette() : super(_defaultColor);

  static const int _defaultColor = 0xFFFFFFFF;
  static const int _pressedColor = 0xFFFFFFFF;

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
