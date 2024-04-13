import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';

var currencyValue = new NumberFormat.compact();

class Slots extends StatefulWidget {
  const Slots({Key? key}) : super(key: key);
  @override
  State<Slots> createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  var bet_input = "0.00";
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
            Text('\$' + bet_input,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + bet_input,
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
                  await Play_Slots(double.parse(bet_input));
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
                    bet_input = "0.00";
                  });
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                bet_input =
                    bet_input + currencyValue.format(double.parse(value));
                setState(() {
                  bet_input = bet_input;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (bet_input.isEmpty ||
                    bet_input == '0.00' ||
                    bet_input == '-0.00') return;
                setState(() {
                  bet_input =
                      bet_input.substring(0, bet_input.length - 1);
                  if (bet_input.isEmpty ||
                      bet_input == '0.00' ||
                      bet_input == '-0.00') {
                    bet_input = '0.00';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (bet_input.isEmpty) return;
                setState(() {
                  bet_input = '0.00';
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

  Future<void> Play_Slots(double bet) async {
    var reqs = {"token": sessiontoken, "bet": bet.toString()};
    if (bet > double.parse(balance)) {
      request("PlaySlots", reqs);
    } else {
      Fluttertoast.showToast(
          msg: "Bet Too Large!",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          webPosition: "center",
          webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
          fontSize: 40);
    }
  }
}
