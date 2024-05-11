import 'package:flutter/material.dart';
import 'package:front_end/generics.dart';
import "package:front_end/slots.dart";
import 'package:front_end/blackjack.dart';
import 'package:front_end/roulette.dart';

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
        appBar: App_Bar(context),
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
                                icon: Image.asset('assets/images/card-deck.png',
                                    color: Colors.black,
                                    height: 128.0,
                                    width: 128.0),
                                onPressed: (() => MaterialPageRoute(
                                                builder: (context) =>
                                                    Blackjack()))))),
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
                                      'assets/images/roulette.png',
                                      color: Colors.black,
                                      height: 128.0,
                                      width: 128.0),
                                  onPressed: (() => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RouletteClass()))
                                      })))),
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
                                      'assets/images/slot-machine.png',
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
