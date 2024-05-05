import 'package:flutter/material.dart';
import 'package:roulette/roulette.dart';

var Roulette_Order = [
  '0',
  '28',
  '9',
  '26',
  '30',
  '11',
  '7',
  '20',
  '32',
  '17',
  '5',
  '22',
  '34',
  '15',
  '3',
  '24',
  '36',
  '13',
  '1',
  '00',
  '27',
  '10',
  '25',
  '29',
  '12',
  '8',
  '19',
  '31',
  '18',
  '6',
  '21',
  '33',
  '16',
  '4',
  '23',
  '35',
  '14',
  '2'
];

List<RouletteUnit> Roulette_Generator() {
  List<RouletteUnit> output = <RouletteUnit>[];
  for (String i in Roulette_Order) {
    int num = int.parse(i);
    output.add(RouletteUnit.text(i,
        textStyle: TextStyle(color: Colors.white), color: color_finder(num)));
  }
  return output;
}

Color color_finder(int num) {
  Color num_color = Colors.red;
  if (num == 0) {
    num_color = Colors.green;
  } else if ((num % 2 == 0 && (num <= 10 || 19 <= num && num <= 28)) ||
      (num % 2 != 0 && (num >= 29 || 11 <= num && num <= 18))) {
    num_color = Colors.black;
  }
  return num_color;
}
