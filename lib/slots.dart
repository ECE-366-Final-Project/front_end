import 'dart:io';

import 'package:front_end/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'appbar.dart';


class Slots_Home extends StatelessWidget {
  Slots_Home({Key? key, required this.title, required this.userID, required this.theme}) : super(key: key);
  final String title;
  final String userID;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slots main page',
      theme: this.theme,
      home: Slots_Frontend(this.userID),
    );
  }

}

class Slots_Frontend extends StatefulWidget {

  Slots_Frontend(this.userID);
  final String userID;
  //SET THIS BY Database!

  @override
  State<Slots_Frontend> createState() => _Slots_State();
}

class _Slots_State extends State<Slots_Frontend> {
    Future<String> play_game(String api_host, String userID, String bet) async {
      final params = {
        "userID": userID,
        "bet": bet,
      };
      // This is the call that needs to be made
      final data = Uri.http(api_host,"/PlaySlots",params);
      final payload = await http.get(data);
      if (payload.statusCode == 200) {
        return payload.body;
      }    
      throw Exception("GAME FAILED");
    }


  int maxbet = 500;
  int bet_value = -1;
  bool ready_to_bet = false;
  bool bet_placed = false;

  bool ValidBet(String value){
    if(int.tryParse(value) != null && int.parse(value) < maxbet){
      bet_value  = int.parse(value);
      print(value + " Is a valid bet!");
      return true;
    }
    print(value);
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child:
        Column(children: [
        TextField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter your bet here,",
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold)),
          onSubmitted: (String value) {ready_to_bet = ValidBet(value);},
        ),
        ready_to_bet ? Text(play_game(bet_value),)
        ],
        )
      ),


    );
  }

}

