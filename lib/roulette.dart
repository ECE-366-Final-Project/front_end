import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/arrow.dart';
import 'package:roulette/roulette.dart';

var currencyValue = new NumberFormat.compact();
String rouletteBetText = "0.00";
String rouletteTempBalance = "";
bool play = false;
List<Widget> betTable = [];

final units = [
  RouletteUnit.text('00',
      textStyle: TextStyle(color: Colors.white), color: Colors.green),
  RouletteUnit.text('27',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('10',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('35',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('29',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('12',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('8',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('19',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('31',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('18',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('6',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('21',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('33',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('16',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('4',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('23',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('35',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('14',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('2',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('0',
      textStyle: TextStyle(color: Colors.white), color: Colors.green),
  RouletteUnit.text('28',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('9',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('26',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('30',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('11',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('7',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('20',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('32',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('17',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('5',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('22',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('34',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('15',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('3',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('24',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('36',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
  RouletteUnit.text('13',
      textStyle: TextStyle(color: Colors.white), color: Colors.black),
  RouletteUnit.text('1',
      textStyle: TextStyle(color: Colors.white), color: Colors.red),
];
List<bool> tappedIn = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
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
                  await controller.rollTo(2, offset: Random().nextDouble());
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
            SizedBox(height: 30.0),
            SizedBox(
                child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 350.0,
                  width: 350.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Roulette(
                      controller: controller,
                      style: const RouletteStyle(
                        dividerThickness: 0.0,
                        dividerColor: Colors.white,
                        centerStickSizePercent: 0.05,
                        centerStickerColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Arrow(),
              ],
            )),
            SizedBox(height: 50.0),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              height: 90.0,
              width: 360.0,
              child: GridView.count(
                crossAxisCount: 12,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tappedIn[0] = !tappedIn[0];
                      });
                    },
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      color: tappedIn[0] ? Colors.white : Colors.red,
                      child: Center(
                        child: Text('3',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tappedIn[1] = !tappedIn[1];
                      });
                    },
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      color: tappedIn[1] ? Colors.white : Colors.black,
                      child: Center(
                        child: Text('6',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tappedIn[2] = !tappedIn[2];
                      });
                    },
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      color: tappedIn[2] ? Colors.white : Colors.red,
                      child: Center(
                        child: Text('9',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tappedIn[3] = !tappedIn[3];
                      });
                    },
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      color: tappedIn[3] ? Colors.white : Colors.red,
                      child: Center(
                        child: Text('12',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[4] = !tappedIn[4];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[4] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('15',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[5] = !tappedIn[5];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[5] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('18',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[6] = !tappedIn[6];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[6] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('21',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[7] = !tappedIn[7];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[7] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('24',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[8] = !tappedIn[8];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[8] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('27',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[9] = !tappedIn[9];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[9] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('30',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[10] = !tappedIn[10];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[10] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('33',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[11] = !tappedIn[11];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[11] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('36',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[12] = !tappedIn[12];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[12] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[13] = !tappedIn[13];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[13] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('5',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[14] = !tappedIn[14];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[14] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('8',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[15] = !tappedIn[15];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[15] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('11',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[16] = !tappedIn[16];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[16] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('14',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[17] = !tappedIn[17];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[17] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('17',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[18] = !tappedIn[18];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[18] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('20',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[19] = !tappedIn[19];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[19] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('23',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[20] = !tappedIn[20];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[20] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('26',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[21] = !tappedIn[21];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[21] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('29',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[22] = !tappedIn[22];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[22] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('32',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[23] = !tappedIn[23];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[23] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('35',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[24] = !tappedIn[24];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[24] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[25] = !tappedIn[25];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[25] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('4',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[26] = !tappedIn[26];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[26] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('7',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[27] = !tappedIn[27];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[27] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('10',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[28] = !tappedIn[28];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[28] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('13',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[29] = !tappedIn[29];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[29] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('16',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[30] = !tappedIn[30];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[30] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('19',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[31] = !tappedIn[31];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[31] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('22',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[32] = !tappedIn[32];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[32] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('25',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[33] = !tappedIn[33];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[33] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('28',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[34] = !tappedIn[34];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[34] ? Colors.white : Colors.black,
                          child: Center(
                              child: Text('31',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          tappedIn[35] = !tappedIn[35];
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          color: tappedIn[35] ? Colors.white : Colors.red,
                          child: Center(
                              child: Text('34',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold))))),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[56] = !tappedIn[56];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[56] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[57] = !tappedIn[57];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[57] ? Colors.white : Colors.red,
                    child: Center(
                      child: Text('Red',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[58] = !tappedIn[58];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[58] ? Colors.white : Colors.black,
                    child: Center(
                      child: Text('Black',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 90.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[59] = !tappedIn[59];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[59] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('00',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[36] = !tappedIn[36];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[36] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('Row 1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[37] = !tappedIn[37];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[37] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('Row 2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[38] = !tappedIn[38];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[38] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('Row 3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[39] = !tappedIn[39];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[39] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C1',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[40] = !tappedIn[40];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[40] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[41] = !tappedIn[41];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[41] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[42] = !tappedIn[42];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[42] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C4',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[43] = !tappedIn[43];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[43] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C5',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[44] = !tappedIn[44];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[44] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C6',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[45] = !tappedIn[45];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[45] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C7',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[46] = !tappedIn[46];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[46] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C8',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[47] = !tappedIn[47];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[47] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C9',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[48] = !tappedIn[48];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[48] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C10',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[49] = !tappedIn[49];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[49] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C11',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 30.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[50] = !tappedIn[50];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[50] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('C12',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[51] = !tappedIn[51];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[51] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('1st 12',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[52] = !tappedIn[52];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[52] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('2nd 12',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 120.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[53] = !tappedIn[53];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[53] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('3rd 12',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 150.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[54] = !tappedIn[54];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[54] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('1st Half',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                height: 30.0,
                width: 150.0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      tappedIn[55] = !tappedIn[55];
                    });
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    color: tappedIn[55] ? Colors.white : Colors.green,
                    child: Center(
                      child: Text('2nd Half',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
