import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:roulette/roulette.dart';
import 'generics.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String rouletteBet = "0";
const tile_dim = 45.0;
bool play = true;
int timeout = 0;
int current = 0;
int gameID = -1;

var temp_balance = balance;
List<bool> tappedIn = List.filled(64, false);
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
Map<String, dynamic> bet_data = {
  "single": {"1": "0"},
  "horizontal": {"1": "0"},
  "vertical": {"1": "0"},
  "red": "0",
  "black": "0",
  "first_half": "0",
  "second_half": "0",
  "first_dozen": "0",
  "second_dozen": "0",
  "third_dozen": "0"
};

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

Future<Response> roulette_request(String token, String args) {
//This function grabs our request from the database, returning the json as a map.
// It also displays error or status messages with an optional flag
  var token_json = {"token": token};
  Uri call = Uri.http(SRC, "/PlayRoulette", token_json);
  var col_str = "linear-gradient(to right, #4E6A54, #4E6A54)";
  try {
    return http
        .post(call, body: utf8.encode(args))
        .timeout(const Duration(seconds: 30));
  } on TimeoutException {
    col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
    Fluttertoast.showToast(
        msg: "Failed To Connect to Server! Please Try again Later",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40,
        timeInSecForIosWeb: 6);
    throw new TimeoutException("FAILED TO CONNECT TO SERVER");
  }
}

Play_Roulette({multiplayer = false}) async {
  //String timeout = request("roulette_timeout");
  //As we're doing roulette differently, I've had to redefine the request system specifically for this game.
  String packet = jsonEncode(bet_data);
  if (multiplayer) {
    bet_data["isqueued"] = "true";
    var data = await roulette_request(sessiontoken, packet);
    //This should be recieved by the server somehow
    timeout = 5;
    current = 5;
    play = false;
    //More Processing Should be Done
  }
  var data = await roulette_request(sessiontoken, packet);
  var map = json.decode(data.body);
  if (data.statusCode > 200) {
    Fluttertoast.showToast(
        msg: map["MESSAGE"]!,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
        fontSize: 40,
        timeInSecForIosWeb: 6);
  }
  return [data.statusCode, map];
}

void output_roll_data(List roll_data, double bet) {
  var Json = roll_data[1];
  var winnings = Json["WINNINGS"];
  var col_str = "linear-gradient(to right, #4E6A54, #4E6A54)";
  var str_wins = winnings.toStringAsFixed(2);
  var msg = "You won \$" + str_wins + "!";
  if (winnings == 0) {
    msg = "You won \$" + str_wins + ". Better luck next time!";
    col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
  }
  Future.delayed(Duration(seconds: 2), () {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40);
    // feed.add(accountItems("Slots", r"$" + str_wins, status));
    // Do something
  });
}

int Roll_Finder(String api_roll) {
  if (api_roll == '37') {
    api_roll = "00";
  }
  return Roulette_Order.indexOf(api_roll);  
}
