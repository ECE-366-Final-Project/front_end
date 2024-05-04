import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:roulette/roulette.dart';

var currencyValue = new NumberFormat.compact();
String rouletteBetText = "0.00";
String rouletteTempBalance = "";
bool play = false;

final units = [
  RouletteUnit.text('00', color: Colors.green),
  RouletteUnit.text('27', color: Colors.red),
  RouletteUnit.text('10', color: Colors.black),
  RouletteUnit.text('35', color: Colors.red),
  RouletteUnit.text('29', color: Colors.black),
  RouletteUnit.text('12', color: Colors.red),
  RouletteUnit.text('8', color: Colors.black),
  RouletteUnit.text('19', color: Colors.red),
  RouletteUnit.text('31', color: Colors.black),
  RouletteUnit.text('18', color: Colors.red),
  RouletteUnit.text('6', color: Colors.black),
  RouletteUnit.text('21', color: Colors.red),
  RouletteUnit.text('33', color: Colors.black),
  RouletteUnit.text('16', color: Colors.red),
  RouletteUnit.text('4', color: Colors.black),
  RouletteUnit.text('23', color: Colors.red),
  RouletteUnit.text('35', color: Colors.black),
  RouletteUnit.text('14', color: Colors.red),
  RouletteUnit.text('2', color: Colors.black),
  RouletteUnit.text('0', color: Colors.green),
  RouletteUnit.text('28', color: Colors.black),
  RouletteUnit.text('9', color: Colors.red),
  RouletteUnit.text('26', color: Colors.black),
  RouletteUnit.text('30', color: Colors.red),
  RouletteUnit.text('11', color: Colors.black),
  RouletteUnit.text('7', color: Colors.red),
  RouletteUnit.text('20', color: Colors.black),
  RouletteUnit.text('32', color: Colors.red),
  RouletteUnit.text('17', color: Colors.black),
  RouletteUnit.text('5', color: Colors.red),
  RouletteUnit.text('22', color: Colors.black),
  RouletteUnit.text('34', color: Colors.red),
  RouletteUnit.text('15', color: Colors.black),
  RouletteUnit.text('3', color: Colors.red),
  RouletteUnit.text('24', color: Colors.black),
  RouletteUnit.text('36', color: Colors.red),
  RouletteUnit.text('13', color: Colors.black),
  RouletteUnit.text('1', color: Colors.red),
];

class RouletteClass extends StatefulWidget {
  const RouletteClass({Key? key}) : super(key: key);
  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<RouletteClass>
    with SingleTickerProviderStateMixin {
  late RouletteController controller;

  @override
  void initState() {
    super.initState();
    controller = RouletteController(vsync: this, group: RouletteGroup(units));
  }

  void onStart(List<int> result) {}

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
            Text('\$' + balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () async {
                      int status = await Withdraw('1');
                      String data = await balanceUpdate();
                      setState(() {
                        balance = data;
                        if (status == 200) {
                          feed.add(
                              accountItems("Roulette", r"$" + '1', "Loss"));
                        }
                      });
                    },
                    child: Text('\$1',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () async {
                      int status = await Withdraw('5');
                      String data = await balanceUpdate();
                      setState(() {
                        balance = data;
                        if (status == 200) {
                          feed.add(
                              accountItems("Roulette", r"$" + '5', "Loss"));
                        }
                      });
                    },
                    child: Text('\$5',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () async {
                      int status = await Withdraw('10');
                      String data = await balanceUpdate();
                      setState(() {
                        balance = data;
                        if (status == 200) {
                          feed.add(
                              accountItems("Roulette", r"$" + '10', "Loss"));
                        }
                      });
                    },
                    child: Text('\$10',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () async {
                      int status = await Withdraw('50');
                      String data = await balanceUpdate();
                      setState(() {
                        balance = data;
                        if (status == 200) {
                          feed.add(
                              accountItems("Roulette", r"$" + '50', "Loss"));
                        }
                      });
                    },
                    child: Text('\$50',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)))
              ],
            ),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Play',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  await controller.rollTo(2);
                  var curtime = DateTime.now();
                  if (ratelimit.difference(curtime).inSeconds > 10) {
                    var col_str = "linear-gradient(to right, #ced111, #ced111)";
                    Fluttertoast.showToast(
                        msg:
                            "The current round is not over. Please wait before rolling again",
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.black,
                        webPosition: "center",
                        webBgColor: col_str,
                        fontSize: 40);
                  } else {
                    ratelimit = curtime;
                    //TODO: Make this one function call, no logic should be completed in this area
                    var roll_data =
                        await Play_Roulette(double.parse(rouletteBetText));
                    if (roll_data[0] == 200) {
                      setState(() {
                        balance = (double.parse(balance) -
                                double.parse(rouletteBetText))
                            .toString();
                      });
                      String roll_reference =
                          roll_data[1]["PAYOUT_ID"].toString();
                      //Straightens string to ensure that it works fine, then converts it to an integer
                      List<int> roll_labels = [];
                      for (var string_roll
                          in roll_reference.padLeft(3, "0").split('')) {
                        roll_labels.add(int.parse(string_roll));
                      }
                      onStart(roll_labels);
                      output_roll_data(
                          roll_data, double.parse(rouletteBetText));
                      var newbal;
                      await Future.delayed(Duration(seconds: 10), () async {
                        newbal = await balanceUpdate(); //
                      });
                      //after
                      setState(() {
                        balance = newbal;
                      });
                    }
                  }
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
                    rouletteBetText = "0.00";
                    rouletteTempBalance = '';
                  });
                },
              ),
            ]),
            SizedBox(height: 20.0),
            Row(children: [
              SizedBox(width: 30.0),
            ]),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }

  Future<int> Withdraw(String depoWithText) async {
    var data = await request(
        "Withdraw", {"token": sessiontoken, "amount": depoWithText});
    return data[0];
  }

  Image img_getter(String path) {
    return Image.asset(path);
  }

  Future<List> Play_Roulette(double bet) async {
    var reqs = {"token": sessiontoken, "bet": bet.toString()};
    var data = await request("PlayRoulette", reqs, Toast: false);
    return data;
  }
}

void output_roll_data(List roll_data, double bet) {
  var Json = roll_data[1];
  var winnings = Json["WINNINGS"];
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  var str_wins = winnings.toStringAsFixed(2);
  var msg = "You won \$" + str_wins + "!";
  var status = "Win";
  if (winnings < bet) {
    status = "Loss";
    msg = "You won \$" + str_wins + ". Better luck next time!";
    col_str = "linear-gradient(to right, #ced111, #ced111)";
  }
  Future.delayed(Duration(seconds: 10), () {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40);
    feed.add(accountItems("Roulette", r"$" + str_wins, status));

    // Do something
  });
}
