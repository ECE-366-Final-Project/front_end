//This file holds things that are commonly shared amongst different pages:
//EG: The homebar, special functions (the HTTP get system), and global variables that are shared and should be updated as one.
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/color-palette.dart';
import 'package:front_end/leaderboard.dart';
import 'package:front_end/slots.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/home.dart';
import 'dart:convert';
import 'package:front_end/blackjack.dart';
import 'package:front_end/roulette.dart';

String balance = '0.00';
String user_reference = "";
String sessiontoken = '0.00';
DateTime ratelimit = DateTime(2023);
var feed = <Widget>[];

const SRC = "cheesegrater.ee.cooper.edu:8080";
Future<List> request(String command, Map<String, String> args,
    {bool Toast = true}) async {
  double toastsize = 20.0;
  if (kIsWeb) {
    toastsize = 40.0;
  }
  var call;
  String body = '''{"MESSAGE": "Failed! Please Try again Later"}''';
  var color = const Color(0xff00b09b);
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  if (args.isNotEmpty) {
    call = Uri.http(SRC, "/" + command, args);
  } else {
    call = Uri.http(SRC, "/" + command);
  }
  print(call);
  int status = 405;
  print(call);
  try {
    final packet = await http.get(call).timeout(const Duration(seconds: 3));
    status = packet.statusCode;
    body = packet.body;
    if (status > 400) {
      color = const Color(0xffdc1c13);
      col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
    }
  } on TimeoutException {
    body =
        '''{"MESSAGE": "Failed To Connect to Server! Please Try again Later"}''';
    color = const Color(0xffdc1c13);
    col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
    Toast = true;
  }
  var map = json.decode(body);
  print(map);
  if (Toast || status > 400) {
    Fluttertoast.showToast(
        msg: map["MESSAGE"]!,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        backgroundColor: color,
        webBgColor: col_str,
        fontSize: toastsize,
        timeInSecForIosWeb: 6);
  }
  return [status, map];
}

Future<String> balanceUpdate() async {
  var call = Uri.http(SRC, "/GetBal", {"token": sessiontoken});
  final packet = await http.get(call).timeout(const Duration(seconds: 5));
  return json.decode(packet.body)["BALANCE"].toString();
}

App_Bar(context) {
  return AppBar(
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
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
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
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Blackjack()))),
            TextButton(
                child: Text('ROULETTE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouletteClass()))
                    }),
            TextButton(
                child: Text('SLOTS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Slots()))),
          ]),
      Text("|",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold)),
      TextButton(
          child: Text('BALANCE: \$ ' + balance,
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
          icon: const Icon(Icons.account_circle,
              color: Colors.white, size: 40.0, semanticLabel: 'User Account'),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Account()))),
      Text("|",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold)),
      IconButton(
          icon: const Icon(Icons.leaderboard,
              color: Colors.white, size: 40.0, semanticLabel: 'Leaderboard'),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Leaderboard()))),
    ],
  );
}
