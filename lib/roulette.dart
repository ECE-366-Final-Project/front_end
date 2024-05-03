import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';

var currencyValue = new NumberFormat.compact();
String slotBetText = "0.00";
String slotTempBalance = "";
bool play = false;

class Roulette extends StatefulWidget {
  const Roulette({Key? key}) : super(key: key);
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
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
            Text('\$' + slotBetText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Play',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  var curtime = DateTime.now();
                  if (ratelimit.difference(curtime).inSeconds > 10) {
                    var col_str = "linear-gradient(to right, #ced111, #ced111)";
                    Fluttertoast.showToast(
                        msg:
                            "The current round is not over. Please wait before rolling again",
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.black,
                        webPosition: "center",
                        webBgColor: col_str,
                        fontSize: 40);
                  }
                },
              ),
              SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Clear',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    slotBetText = "0.00";
                    slotTempBalance = '';
                  });
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                slotTempBalance =
                    slotTempBalance + currencyValue.format(double.parse(value));
                setState(() {
                  slotBetText = slotTempBalance;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (slotBetText.isEmpty ||
                    slotBetText == '0.00' ||
                    slotBetText == '-0.00') return;
                setState(() {
                  slotBetText =
                      slotBetText.substring(0, slotBetText.length - 1);
                  slotTempBalance = slotBetText;
                  if (slotBetText.isEmpty ||
                      slotBetText == '0.00' ||
                      slotBetText == '-0.00') {
                    slotBetText = '0.00';
                    slotTempBalance = '';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (slotBetText.isEmpty) return;
                setState(() {
                  slotBetText = '0.00';
                  slotTempBalance = '';
                });
              },
              rightIcon: const Icon(
                Icons.backspace_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }

  Image img_getter(String path) {
    return Image.asset(path);
  }

  Future<List> Play_Roulette(double bet) async {
    var reqs = {"token": sessiontoken, "bet": bet.toString()};
    var data = await request("PlayRoulette", reqs, Toast: false);
    return data;
  }
}

void output_roll_data(List roll_data, double bet) {
  var Json = roll_data[1];
  var winnings = Json["WINNINGS"];
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  var str_wins = winnings.toStringAsFixed(2);
  var msg = "You won \$" + str_wins + "!";
  var status = "Win";
  if (winnings < bet) {
    status = "Loss";
    msg = "You won \$" + str_wins + ". Better luck next time!";
    col_str = "linear-gradient(to right, #ced111, #ced111)";
  }
  Future.delayed(Duration(seconds: 10), () {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40);
    // feed.add(accountItems("Roulette", r"$" + str_wins, status));

    // Do something
  });
}
