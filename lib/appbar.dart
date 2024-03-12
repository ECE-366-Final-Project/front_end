import 'package:flutter/material.dart';
import "main.dart";
import "slots.dart" as slots;

appBar_get(context) {
  return AppBar(
        title: new TextButton(
            child: Text('♤♡ COOPER CASINO ♢♧',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()))),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        actions: [
          TextButton(
              child: Text('BLACKJACK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
          Text("|",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),

          TextButton(
              child: Text('SLOTS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                context, MaterialPageRoute(builder: (context) => slots.Slots_Home(title: "Play Slots", userID: userID,theme: globtheme,)));}
                  ),
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
        ],
      );
}