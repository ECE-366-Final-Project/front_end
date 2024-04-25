import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';

var currencyValue = new NumberFormat.compact();
String bj_bet_text = "0.00";
String slotTempBalance = "";
bool play = false;
String backOfCard = 'sprites/cards/face-pngs/background_default.png';
List<String> deck = [
  'sprites/cards/face-pngs/1C.png',
  'sprites/cards/face-pngs/1D.png',
  'sprites/cards/face-pngs/1H.png',
  'sprites/cards/face-pngs/1S.png',
  'sprites/cards/face-pngs/2C.png',
  'sprites/cards/face-pngs/2D.png',
  'sprites/cards/face-pngs/2H.png',
  'sprites/cards/face-pngs/2S.png',
  'sprites/cards/face-pngs/3C.png',
  'sprites/cards/face-pngs/3D.png',
  'sprites/cards/face-pngs/3H.png',
  'sprites/cards/face-pngs/3S.png',
  'sprites/cards/face-pngs/4C.png',
  'sprites/cards/face-pngs/4D.png',
  'sprites/cards/face-pngs/4H.png',
  'sprites/cards/face-pngs/4S.png',
  'sprites/cards/face-pngs/5C.png',
  'sprites/cards/face-pngs/5D.png',
  'sprites/cards/face-pngs/5H.png',
  'sprites/cards/face-pngs/5S.png',
  'sprites/cards/face-pngs/6C.png',
  'sprites/cards/face-pngs/6D.png',
  'sprites/cards/face-pngs/6H.png',
  'sprites/cards/face-pngs/6S.png',
  'sprites/cards/face-pngs/7C.png',
  'sprites/cards/face-pngs/7D.png',
  'sprites/cards/face-pngs/7H.png',
  'sprites/cards/face-pngs/7S.png',
  'sprites/cards/face-pngs/8C.png',
  'sprites/cards/face-pngs/8D.png',
  'sprites/cards/face-pngs/8H.png',
  'sprites/cards/face-pngs/8S.png',
  'sprites/cards/face-pngs/9C.png',
  'sprites/cards/face-pngs/9D.png',
  'sprites/cards/face-pngs/9H.png',
  'sprites/cards/face-pngs/9S.png',
  'sprites/cards/face-pngs/AC.png',
  'sprites/cards/face-pngs/AD.png',
  'sprites/cards/face-pngs/AH.png',
  'sprites/cards/face-pngs/AS.png',
  'sprites/cards/face-pngs/JC.png',
  'sprites/cards/face-pngs/JD.png',
  'sprites/cards/face-pngs/JH.png',
  'sprites/cards/face-pngs/JS.png',
  'sprites/cards/face-pngs/KC.png',
  'sprites/cards/face-pngs/KD.png',
  'sprites/cards/face-pngs/KH.png',
  'sprites/cards/face-pngs/KS.png',
  'sprites/cards/face-pngs/QC.png',
  'sprites/cards/face-pngs/QD.png',
  'sprites/cards/face-pngs/QH.png',
  'sprites/cards/face-pngs/QS.png',
];
List<Image> dealerCards = [];
List<Image> playerCards = [];

cardChange(List<Image> deck, String face, String command) {
  if (command == "add") {
    deck.add(Image.asset(face));
  } else if (command == "remove") {
    deck.remove(Image.asset(face));
  }
}

cardFlip(List<Image> deck, int index) {
  if (deck.elementAt(index).toString() != backOfCard) {
    //flip to back of card
  } else {
    //flip to front of card
  }
}

Row cardItems() {
  return Row(children: []);
}

class Blackjack extends StatefulWidget {
  const Blackjack({Key? key}) : super(key: key);
  @override
  _BlackjackState createState() => _BlackjackState();
}

class _BlackjackState extends State<Blackjack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooper Casino',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData().copyWith(
          scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
          splashColor: Colors.white,
          focusColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.white)),
      home: Scaffold(
        appBar: App_Bar(context),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100.0),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + bj_bet_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            !play
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Play',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        var curtime = DateTime.now();
                        if (ratelimit.difference(curtime).inSeconds > 10) {
                          var col_str =
                              "linear-gradient(to right, #ced111, #ced111)";
                          Fluttertoast.showToast(
                              msg:
                                  "The current round is not over. Please wait before rolling again",
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.black,
                              // webPosition: "center", // :3 I Was here
                              webBgColor: col_str,
                              fontSize: 40);
                          return;
                        }
                        ratelimit = curtime;
                        var payload =
                            await StartBlackjack(double.parse(bj_bet_text));
                        if (payload[0] < 400) {
                          setState(() {
                            play = true;
                          });
                        }
                      },
                    ),
                    SizedBox(width: 20.0),
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Clear',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          bj_bet_text = "0.00";
                          slotTempBalance = '';
                        });
                      },
                    ),
                    SizedBox(width: 20.0),
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Rejoin Game',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        var payload = await RejoinBlackjack();
                        if (payload[0] < 400) {
                          setState(() {
                            play = true;
                          });
                        }
                      },
                    )
                  ])
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.add_circle_rounded,
                                      color: Colors.green,
                                      size: 40.0,
                                      semanticLabel: 'Hit'),
                                  onPressed: () async {
                                    bool data = await blackjack_call("hit");
                                    State_Setter(data);
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.stop_circle_rounded,
                                      color: Colors.red,
                                      size: 40.0,
                                      semanticLabel: 'Stand'),
                                  onPressed: () async {
                                    bool data = await blackjack_call("stand");
                                    State_Setter(data);
                                  }),
                              IconButton(
                                  icon: const Icon(
                                      Icons.exposure_plus_2_rounded,
                                      color: Colors.green,
                                      size: 40.0,
                                      semanticLabel: 'Double Down'),
                                  onPressed: () async {
                                    bool data =
                                        await blackjack_call("double_down");
                                    State_Setter(data);
                                  }),
                            ]),
                        SizedBox(height: 50.0),
                        ListView(
                            scrollDirection: Axis.horizontal, children: []),
                        SizedBox(height: 100.0),
                        ListView(scrollDirection: Axis.horizontal, children: [])
                      ],
                    ),
                  ),
            !play
                ? NumericKeyboard(
                    onKeyboardTap: (String value) {
                      slotTempBalance = slotTempBalance +
                          currencyValue.format(double.parse(value));
                      setState(() {
                        bj_bet_text = slotTempBalance;
                      });
                    },
                    mainAxisAlignment: MainAxisAlignment.center,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                    rightButtonFn: () {
                      if (bj_bet_text.isEmpty ||
                          bj_bet_text == '0.00' ||
                          bj_bet_text == '-0.00') return;
                      setState(() {
                        bj_bet_text =
                            bj_bet_text.substring(0, bj_bet_text.length - 1);
                        slotTempBalance = bj_bet_text;
                        if (bj_bet_text.isEmpty ||
                            bj_bet_text == '0.00' ||
                            bj_bet_text == '-0.00') {
                          bj_bet_text = '0.00';
                          slotTempBalance = '';
                        }
                      });
                    },
                    rightButtonLongPressFn: () {
                      if (bj_bet_text.isEmpty) return;
                      setState(() {
                        bj_bet_text = '0.00';
                        slotTempBalance = '';
                      });
                    },
                    rightIcon: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.white,
                    ),
                  )
                : Container(),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }

  Future<void> State_Setter(bool game_running) async {
    if (!game_running) {
      var temp_bal = await balanceUpdate();
      setState(() {
        balance = temp_bal;
      });
    }
    setState(() {
      play = game_running;
    });
  }
}

void render(var json) {
  //TODO: Make
  String str = "";
  if (json["GAME_ENDED"] == "true") {
    str = "Game over! Winner: " + json["WINNER"];
  }
  str += "\n Your Hand: " + json["PLAYERS_CARDS"];
  str += "\n Dealer Hand: " + json["DEALERS_CARDS"];
  Fluttertoast.showToast(
      msg: str,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black,
      webPosition: "center",
      fontSize: 40,
      timeInSecForIosWeb: 10);
}

Future<bool> blackjack_call(String s) async {
  var reqs = {"token": sessiontoken, "move": s};
  var data = await request("UpdateBlackjack", reqs, Toast: false);
  if (data[0] == 200) {
    render(data[1]);
  }
  print(data[1]["GAME_ENDED"]);
  return (!(data[1]["GAME_ENDED"] == "true"));
}

Future<List> RejoinBlackjack() async {
  var reqs = {"token": sessiontoken};
  var data = await request("RejoinBlackjack", reqs, Toast: false);
  if (data[0] == 200) {
    render(data[1]);
  }
  return data;
}

Future<List> StartBlackjack(double bet) async {
  var reqs = {"token": sessiontoken, "bet": bet.toString()};
  var data = await request("NewBlackjack", reqs, Toast: false);
  if (data[0] == 200) {
    render(data[1]);
  } else if (data[0] == 412) {
    return RejoinBlackjack();
  }
  return data;
}
