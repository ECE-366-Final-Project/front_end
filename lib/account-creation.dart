// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/account-login.dart';

class AccountCreation extends StatelessWidget {
  String username = "";
  String password1 = "";
  String password2 = "";

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
                    child: Image.asset('assets/images/login_logo.png')),
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
                  },
                ),
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
                      password1 = value;
                    }
                  },
                ),
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
                  cursorErrorColor: Colors.red,
                  obscureText: true,
                  decoration: InputDecoration(
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Re-Enter Your Password',
                      hintText: 'Re-enter your password'),
                  onChanged: (String? value) {
                    if (value != null) {
                      password2 = value;
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  create_user(username, password1, password2, context);
                },
                child: const Text(
                  'CREATE YOUR ACCOUNT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

create_user(username, password1, password2, context) async {
  print(username);
  print(password1);
  print(password2);
  //Comparing passwords on the frontend.

  if (password1 == password2) {
    final salt = "imposter";

  //A concious decision was made to hash with a salt to ensure that, even in the case of a man-in-the-middle, a user's password is never compromised.
    String passkey =
        sha256.convert(utf8.encode(username + password1 + salt)).toString();
    Map<String, String> args = {"username": username, "passkey": passkey};
    var data = await request("CreateUser", args);
    if (data[0] == 200) {
      print("User Created!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AccountLogin()));
    }
  } else {
    Fluttertoast.showToast(
        msg: "PASSWORDS DO NOT MATCH",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        webPosition: "center",
        webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
        fontSize: 40);
  }
}
