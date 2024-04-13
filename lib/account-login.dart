// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_end/home.dart';
import 'package:front_end/account-creation.dart';
import 'package:front_end/generics.dart';
import 'package:crypto/crypto.dart';

class AccountLogin extends StatelessWidget {
  String username = "DEFAULT_USERNAME";
  String password = "DEFAULT_PASSWORD";

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
          title: Text('COOPER CASINO',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF000000),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('lib/assets/images/login_logo.png')),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: TextFormField(
                    style: TextStyle(
                        color: Colors.white, decorationColor: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: 'Username',
                        hintText: 'Enter your username'),
                    onChanged: (String? value) {
                      if (value != null) {
                        username = value;
                      }
                    }),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: SizedBox(
                width: 350,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.white, decorationColor: Colors.white),
                  cursorColor: Colors.white,
                  obscureText: true,
                  decoration: InputDecoration(
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your password'),
                  onChanged: (String? value) {
                    if (value != null) {
                      password = value;
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () => {log_in(username, password, context)},
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              child: Text('Create an Account',
                  style: TextStyle(color: Colors.white)),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountCreation()))
              },
            )
          ],
        )),
      ),
    );
  }
}

log_in(username, password, context) async {
  final salt = "imposter";
  String passkey = sha256.convert(utf8.encode(username + password + salt)).toString();
  Map<String,String> args = {"username": username, "passkey": passkey};
  var data = await request("LogIn", args);
  if (data[0] == 200) {
    sessiontoken = data[1]["TOKEN"];
    user_reference = username;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }
}
