import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/arrow.dart';
import 'package:roulette/roulette.dart';
import "package:front_end/roulette_generators.dart";

var currencyValue = new NumberFormat.compact();
String rouletteBetText = "0.00";
String rouletteTempBalance = "";
bool play = false;
List<Widget> betTable = [];
const tile_dim = 45.0;

final units = Roulette_Generator();

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
          child: //This child is the selector for placing bets
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                height: tile_dim * 6+2,
                width: tile_dim * 16 + 3,
                child: Board()),
            SizedBox(height: 10.0),
            SizedBox(height: 100.0),
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

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<bool> tappedIn = List.filled(60, false);
  @override
  void initState() {
    super.initState();
  }

  InkWell inkwell_gen(String msg, Color color, int pos, double h, double w) {
    return InkWell(
        child: Container(
            height: h,
            width: w,
            color: tappedIn[pos] ? Colors.white : color,
            child: Center(
                child: Text(msg,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)))),
        onTap: () {
          
          setState(() {
            tappedIn[pos] = !tappedIn[pos];
          });
        });
  }

  Container Containerizer(text, height, width, pos,
      {Color = const Color(0xff4E6A54), Widget? widget = null}) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        height: height,
        width: width,
        child: inkwell_gen(text, Color, pos, tile_dim, tile_dim));
  }

  @override
  Widget build(BuildContext context) {
    //Used to test & implement additional scaling
    const n = 12;
    List<InkWell> tiles = <InkWell>[];
    for (int start in [3, 2, 1]) {
      for (int i = start; i <= 36; i += 3) {
        tiles.add(
            inkwell_gen(i.toString(), color_finder(i), i, tile_dim, tile_dim));
      }
    }
    for (int i = 1; i <= 12; i++) {
      String txt = "C" + i.toString();
      tiles
          .add(inkwell_gen(txt, const Color(0xff4E6A54), 36 + i, tile_dim, tile_dim));
    }
    final main_board = GridView.count(crossAxisCount: n, children: tiles,crossAxisSpacing: 1, mainAxisSpacing: 1,);
    final zero_board = new Column(children: [
      Containerizer("00", tile_dim * 2, tile_dim, 49),
      Containerizer("0", tile_dim, tile_dim, 50)
    ]);

    List<Container> Container_List = [];
    for (int i = 51; i <= 53; i++) {
      Container_List.add(Containerizer('2 to 1', tile_dim, tile_dim * 3, i));
    }
    final column_board = new Column(children: Container_List);

    final upper_row = new Row(children: <Widget>[
      Container(child: zero_board, height: tile_dim * 4, width: tile_dim),
      Container(decoration: BoxDecoration(border: Border.all(color: Colors.white),color: Colors.white), child: main_board, height: tile_dim * 4, width: tile_dim * 12),
      Container(child: column_board, height: tile_dim * 4, width: tile_dim * 3)
    ], mainAxisAlignment: MainAxisAlignment.center);

    const middle_text = ["1st 12", "2nd 12", "3rd 12"];
    final middle_row = Row(children: [
      for (int i = 0; i < middle_text.length; i++)
        Containerizer(middle_text[i], tile_dim, tile_dim * 4, 54 + i),
      Container(height: tile_dim, width: tile_dim * 2)
    ], mainAxisAlignment: MainAxisAlignment.center);

    const bottom_text = ["1 to 18", "EVEN", 'RED', "BLACK", "ODD", "19 to 36"];
    const bottom_colors = [
      const Color(0xff4E6A54),
      const Color(0xff4E6A54),
      Colors.red,
      Colors.black,
      const Color(0xff4E6A54),
      const Color(0xff4E6A54)
    ];
    final bottom_row = Row(children: [
      for (int i = 0; i < bottom_text.length; i++)
        Containerizer(bottom_text[i], tile_dim, tile_dim * 2, 54 + i,
            Color: bottom_colors[i]),
      Container(height: tile_dim, width: tile_dim * 2)
    ], mainAxisAlignment: MainAxisAlignment.center);

    return Column(
      children: [upper_row, middle_row, bottom_row],
      mainAxisAlignment: MainAxisAlignment.center,
    );

    // return Row(
    //   children: [zero_board, main_board],
    //   mainAxisAlignment: MainAxisAlignment.center,
    // );
  }
}

void output_roll_data(List roll_data, double bet) {
  var Json = roll_data[1];
  var winnings = Json["WINNINGS"];
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  var str_wins = winnings.toStringAsFixed(2);
  var msg = "You won \$" + str_wins + "!";
  if (winnings < bet) {
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
    // Do something
  });
}
