import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/color-palette.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:front_end/account.dart';
import 'package:front_end/home.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
          scaffoldBackgroundColor: const Color(0xFF000000),
          splashColor: Colors.white,
          focusColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.white)),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton(
              child: Text('COOPER CASINO',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))),
          backgroundColor: const Color(0xFF000000),
          elevation: 0,
          actions: [
            MenuAnchor(
                style: MenuStyle(backgroundColor: ColorPalette()),
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return TextButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Text('GAMES',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)));
                },
                menuChildren: [
                  TextButton(
                      child: Text('BLACKJACK',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                  TextButton(
                      child: Text('ROULETTE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                  TextButton(
                      child: Text('SLOTS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                ]),
            Text("|",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            TextButton(
                child: Text('BALANCE: \$ ' + text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DepoWithdraw()))),
            Text("|",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            IconButton(
                icon: const Icon(Icons.account_circle,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'User Account'),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()))),
          ],
        ),
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
    // TODO: Add User Functionality: This currently just returns data given the admin user
    var reqs = {"userID": 0, "user": "admin", "bet": bet.toString()};
    var call = Uri.http(SRC, "/PlaySlots", reqs);
    var txt = "";
    var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
    if (bet > double.parse(text)) {
      try {
        final packet = await http.get(call).timeout(const Duration(seconds: 5));
        txt = packet.body;
      } on TimeoutException {
        txt = "Failed to Connect to Server";
        col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
      }
    } else {
      txt = "Bet Too Large!";
      col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
    }
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40);
  }
}
