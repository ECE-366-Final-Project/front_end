import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/arrow.dart';
import 'package:roulette/roulette.dart';
import "package:front_end/roulette_generators.dart";
import 'package:quiver/async.dart';

var currencyValue = new NumberFormat.compact();
bool play = true;
List<Widget> betTable = [];
final units = Roulette_Generator();
Map<dynamic, dynamic> data = {};

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
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: Colors.white)),
        home: Scaffold(
            appBar: App_Bar(context),
            body: SingleChildScrollView(
                child: //This child is the selector for placing bets
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  SizedBox(height: 50.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(width: 20.0),
                  ]),
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
                  play ? Board() : Leaderboard(),
                ]))));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Image img_getter(String path) {
    return Image.asset(path);
  }

  Widget Board() {
    //Used to test & implement additional scaling
    const n = 12;
    List<InkWell> tiles = <InkWell>[];
    for (int start in [3, 2, 1]) {
      for (int i = start; i <= 36; i += 3) {
        tiles.add(inkwell_gen(
            i.toString(), color_finder(i), i, tile_dim, tile_dim,
            section: "single", label: i.toString()));
      }
    }
    for (int i = 1; i <= 12; i++) {
      String txt = "C" + i.toString();
      tiles.add(inkwell_gen(
          txt, const Color(0xff4E6A54), 36 + i, tile_dim, tile_dim,
          section: "horizontal", label: i.toString()));
    }
    final main_board = GridView.count(
      crossAxisCount: n,
      children: tiles,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
    );
    final zero_board = new Column(children: [
      Containerizer("00", tile_dim * 2, tile_dim, 49,
          section: "single", label: "37"),
      Containerizer(
        "0",
        tile_dim,
        tile_dim,
        50,
        section: "single",
      )
    ]);

    List<Container> Container_List = [];
    //51
    var labels = ['3', '2', '1'];
    for (int i = 1; i <= 3; i++) {
      Container_List.add(Containerizer('2 to 1', tile_dim, tile_dim * 2, i + 50,
          section: "vertical", label: labels[i - 1]));
    }
    final column_board = new Column(children: Container_List);

    final upper_row = new Row(children: <Widget>[
      Container(child: zero_board, height: tile_dim * 4, width: tile_dim),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white), color: Colors.white),
          child: main_board,
          height: tile_dim * 4,
          width: tile_dim * 12),
      Container(child: column_board, height: tile_dim * 4, width: tile_dim * 2)
    ], mainAxisAlignment: MainAxisAlignment.center);

    const middle_text = ["1st 12", "2nd 12", "3rd 12"];
    const middle_jsons = ["first_dozen", "second_dozen", "third_dozen"];
    final middle_row = Row(children: [
      for (int i = 0; i < middle_text.length; i++)
        Containerizer(middle_text[i], tile_dim, tile_dim * 4, 54 + i,
            label: middle_jsons[i]),
      Container(height: tile_dim, width: tile_dim)
    ], mainAxisAlignment: MainAxisAlignment.center);

    const bottom_text = ["1 to 18", "\t", 'RED', "BLACK", "\t", "19 to 36"];
    const bottom_json = [
      "first_half",
      null,
      "red",
      "black",
      null,
      "second_half"
    ];
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
        Containerizer(bottom_text[i], tile_dim, tile_dim * 2, 57 + i,
            Color: bottom_colors[i], label: bottom_json[i]),
      Container(height: tile_dim, width: tile_dim)
    ], mainAxisAlignment: MainAxisAlignment.center);

    return Column(
      children: [
        upper_row,
        middle_row,
        bottom_row,
        SizedBox(height: 20.0),
        play
            ? Text('Balance Remaining: \$' + temp_balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold))
            : Container(),
        play ? SizedBox(height: 10.0) : Container(),
        play
            ? Text('\$' + rouletteBet,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold))
            : Container(),
        SizedBox(
          height: 10.0,
        ),
        play
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    child: Text('Clear',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      setState(() {
                        temp_balance = balance;
                        tappedIn = List.filled(64, false);
                        bet_data = {
                          "single": {"1": "0"},
                          "horizontal": {"1": "0"},
                          "vertical": {"1": "0"},
                          "red": "0",
                          "black": "0",
                          "first_half": "0",
                          "second_half": "0",
                          "first_dozen": "0",
                          "second_dozen": "0",
                          "third_dozen": "0"
                        };
                      });
                    }),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () {
                      setState(() {
                        rouletteBet = "0";
                      });
                    },
                    child: Text('\$0',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () {
                      setState(() {
                        rouletteBet = "1";
                      });
                    },
                    child: Text('\$1',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () {
                      setState(() {
                        rouletteBet = "5";
                      });
                    },
                    child: Text('\$5',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () {
                      setState(() {
                        rouletteBet = "10";
                      });
                    },
                    child: Text('\$10',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    onPressed: () async {
                      setState(() {
                        rouletteBet = "50";
                      });
                    },
                    child: Text('\$50',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))),
              ])
            : Container(),
        SizedBox(height: 20.0),
        play
            ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                  style: ButtonStyle(backgroundColor: DWPalette()),
                  child: Text('Play Singleplayer',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    //Get Time left
                    print(bet_data);
                    //TODO: Implement API Connections & Expand
                    List<dynamic> game_data = await Play_Roulette();
                    if (game_data[0] == 200) {
                      print(game_data[1]);
                      int index =
                          Roll_Finder(game_data[1]["ROLLED_NUMBER"].toString());
                      await controller.rollTo(index);
                      output_roll_data(game_data,
                          double.parse(balance) - double.parse(temp_balance));
                    }
                    setState(() {
                      balanceUpdate();
                    });
                  },
                ),
                SizedBox(width: 20.0),
                TextButton(
                    style: ButtonStyle(backgroundColor: DWPalette()),
                    child: Text('Play Multiplayer',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      //Get Time left
                      print(bet_data);
                      //TODO: Implement API Connections & Expand
                      var game_data = await Play_Roulette(multiplayer: true);
                      print(game_data);
                      setState(() {
                        play = false;
                        timeout;
                      });
                    })
              ])
            : Container(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  InkWell inkwell_gen(String msg, Color color, int pos, double h, double w,
      {String? section = null, String? label = null}) {
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
          double tmp_bal =
              (double.parse(temp_balance) - double.parse(rouletteBet));
          print(label);
          print(section);
          String user_message = "Bet Placed!";
          String input = msg;
          label != null ? input = label : input = msg;
          String col_str = "linear-gradient(to right, #4E6A54, #4E6A54)";
          var bet_value = rouletteBet;
          setState(() {
            if (section != null) {
              if (tappedIn[pos]) {
                temp_balance = (double.parse(temp_balance) +
                        double.parse(bet_data[section][input]))
                    .toString();
              }
              if (tappedIn[pos] ||
                  tmp_bal < 0 ||
                  double.parse(rouletteBet) == 0) {
                col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
                bet_value = "0";
                user_message = "Bet Not Placed";
              } else {
                temp_balance = tmp_bal.toString();
              }
              bet_data[section][input] = bet_value;
            } else {
              temp_balance =
                  (double.parse(temp_balance) + double.parse(bet_data[input]))
                      .toString();
              if (tappedIn[pos] ||
                  tmp_bal < 0 ||
                  double.parse(rouletteBet) == 0) {
                col_str = "linear-gradient(to right, #dc1c13, #dc1c13)";
                bet_value = "0";
                user_message = "Bet Not Placed";
              } else {
                temp_balance = tmp_bal.toString();
              }
              bet_data[input] = bet_value;
            }
            if ((double.parse(rouletteBet) != 0 && tmp_bal >= 0) ||
                tappedIn[pos]) {
              tappedIn[pos] = !tappedIn[pos];
            }
          });
          Fluttertoast.showToast(
              msg: user_message,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              webPosition: "center",
              fontSize: 40,
              webBgColor: col_str,
              timeInSecForIosWeb: 1);
        });
  }

  Container Containerizer(text, height, width, pos,
      {Color = const Color(0xff4E6A54),
      String? section = null,
      String? label = null}) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        height: height,
        width: width,
        child: inkwell_gen(text, Color, pos, tile_dim, tile_dim,
            section: section, label: label));
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: timeout),
      new Duration(seconds: 1),
    );
    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        current = timeout - duration.elapsed.inSeconds;
      });
    });
    sub.onDone(() async {
      sub.cancel();
      await Future.delayed(Duration(milliseconds: 100), () {
        // Do something
      });
      // int index = Roll_Finder(game_data[1]["ROLLED_NUMBER"].toString());
      // controller.rollTo(index);
      setState() {
        //Write data from the api calls so that leaderboard can appropriately process them
      }
    });
  }

  Widget Leaderboard() {
    startTimer();
    if (current > 0) {
      return Column(children: [
        Text(current.toString() + " Seconds Until Roll!",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold))
      ], mainAxisAlignment: MainAxisAlignment.center);
    }
    //Some Request is made here that gets us the player elements, as well as the roll.
    var feed;
    List<Widget> leaderboard_elements = player_extract(feed);
    return Column(
        children: leaderboard_elements,
        mainAxisAlignment: MainAxisAlignment.center);
  }

  List<Widget> player_extract(List<dynamic>? feed) {
    if (feed == null) {
      return [Container()];
    }
    List<Widget> ret_list = <Widget>[];
    //This is the datadump of all 5 latest transactions for each category.
    for (var object in feed) {
      ret_list.add(opponent_items(
          object["username"],
          r"$" + object["bet"].toString(),
          r"$" + object["winnings"].toString()));
    }
    return ret_list;
  }

  Widget redGreenFont(bet, win) {
    // if (double.parse(bet[0].substring(1)) - double.parse(win.substring(1)) > 0) {
    //alternatively
    if (double.parse(bet[0]) - double.parse(win) > 0) {
      //alternatively
      return Text(r"\$" + win,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red));
    } else {
      //alternatively
      return Text(r"\$" + win,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.green));
    }
  }

  Column opponent_items(String name, String bet, String win,
          {Color oddColour = Colors.white}) =>
      Column(children: [
        SizedBox(height: 10.0),
        Container(
            decoration: BoxDecoration(
                color: oddColour,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            padding: EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  redGreenFont(bet, win),
                ],
              ),
              SizedBox(height: 10.0),
              Text(bet,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold))
            ]))
      ]);
}
