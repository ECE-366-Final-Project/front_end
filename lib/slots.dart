import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:front_end/generics.dart';

var currencyValue = new NumberFormat.compact();

class Slots extends StatefulWidget {
  const Slots({Key? key}) : super(key: key);
  @override
  State<Slots> createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
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
            Text('\$' + text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + depoWithText,
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
                  await Play_Slots(double.parse(depoWithText));
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
                    depoWithText = "0.00";
                  });
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                tempBalance =
                    tempBalance + currencyValue.format(double.parse(value));
                setState(() {
                  depoWithText = tempBalance;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (depoWithText.isEmpty ||
                    depoWithText == '0.00' ||
                    depoWithText == '-0.00') return;
                setState(() {
                  depoWithText =
                      depoWithText.substring(0, depoWithText.length - 1);
                  tempBalance = depoWithText;
                  if (depoWithText.isEmpty ||
                      depoWithText == '0.00' ||
                      depoWithText == '-0.00') {
                    depoWithText = '0.00';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (depoWithText.isEmpty) return;
                setState(() {
                  depoWithText = '0.00';
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
    var reqs = {"userID": '1', "bet": bet.toString()};
    // if (bet > double.parse(text)) {
      request("PlaySlots", reqs);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Bet Too Large!",
    //       gravity: ToastGravity.BOTTOM,
    //       textColor: Colors.white,
    //       webPosition: "center",
    //       webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
    //       fontSize: 40);
    // }
  }
}
