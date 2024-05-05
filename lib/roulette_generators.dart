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

List<RouletteUnit> Roulette_Generator(){
  List<RouletteUnit> output = <RouletteUnit>[];
  Color num_color = Colors.red;
  for (String i in Roulette_Order){
    var num = int.parse(i);
    if(num == 0) {
      num_color = Colors.green;
    } else if(num % 2 == 0 && (num < 10 || 19 < num && num < 28) ) {
      num_color = Colors.black;
    }
    output.add(RouletteUnit.text(i, textStyle: TextStyle(color: Colors.white), color: num_color));
  }
  return output;
}
