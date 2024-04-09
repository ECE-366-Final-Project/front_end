//This file holds things that are commonly shared amongst different pages:
//EG: The homebar, special functions (the HTTP get system), and global variables that are shared and should be updated as one.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/color-palette.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/home.dart';


Future<String> request(String command, Map<String,dynamic> args, {Toast = true}) async  {
  const SRC = "localhost:8080";
  var call = Uri.http(SRC, "/" + command, args);
  var txt = "";
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  try{
    final packet = await http.get(call).timeout(const Duration(seconds: 5));
    txt = packet.body;
    if(!Toast){
    }
  } on TimeoutException {
    txt = "Failed to Connect to Server";
    col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
    Toast = true;
    print("Failed Call!");
}
  Toast ? Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      webPosition: "center",
      webBgColor: col_str,
      fontSize: 40): Null;
  return txt;
}

App_Bar(context){
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
                  request("Ping",{});
                }),

            IconButton(
                icon: const Icon(Icons.account_circle,
                    color: Colors.white,
                    size: 40.0,
                    semanticLabel: 'User Account'),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()))),
          ],
        );
}