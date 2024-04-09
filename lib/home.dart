import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/color-palette.dart';
import "package:front_end/slots.dart";
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

const SRC = "localhost:8080";

Future<void> Ping() async {
  var call = Uri.http(SRC, "/Ping");
  var txt = "";
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  try{
  final packet = await http.get(call).timeout(const Duration(seconds: 5));
  txt = packet.body;
} on TimeoutException {
  txt = "Failed to Connect to Server";
  col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
  print("Failed!");
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


class Home extends StatelessWidget {
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
            // This is to test the server connection quickly:
            IconButton(
                icon: Icon(Icons.network_wifi,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'Server Check'),
                onPressed: () async {
                  Ping();
                }),

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200.0),
              OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                alignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                            height: 200.0,
                            width: 200.0,
                            color: Colors.white,
                            child: IconButton(
                                icon: Image.asset(
                                    'lib/assets/images/card-deck.png',
                                    color: Colors.black,
                                    height: 128.0,
                                    width: 128.0),
                                onPressed: (() => {})))),
                    SizedBox(height: 10.0),
                    Text('BLACKJACK',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                              height: 200.0,
                              width: 200.0,
                              color: Colors.white,
                              child: IconButton(
                                  icon: Image.asset(
                                      'lib/assets/images/roulette.png',
                                      color: Colors.black,
                                      height: 128.0,
                                      width: 128.0),
                                  onPressed: (() => {})))),
                      SizedBox(height: 10.0),
                      Text('ROULETTE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                              height: 200.0,
                              width: 200.0,
                              color: Colors.white,
                              child: IconButton(
                                  icon: Image.asset(
                                      'lib/assets/images/slot-machine.png',
                                      color: Colors.black,
                                      height: 128.0,
                                      width: 128.0),
                                  onPressed: (() => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Slots()))
                                      })))),
                      SizedBox(height: 10.0),
                      Text('SLOTS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
              SizedBox(height: 200.0),
            ],
          ),
        ),
      ),
    );
  }
}
