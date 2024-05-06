import 'package:flutter/material.dart';
import 'package:front_end/generics.dart';
import 'package:intl/intl.dart';

List<Widget> blackjack_feed = <Widget>[];
List<Widget> roulette_feed = <Widget>[];
List<Widget> slots_feed = <Widget>[];

redGreenFont(String charge) {
  return Text(charge,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green));
}

displayAccountList(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 500,
          child: TabBar(tabs: [
            Tab(text: "Slots"),
            Tab(text: "Blackjack"),
            Tab(text: "Roulette"),
          ]),
        ),
        Container(
          //Add this to give height
          height: MediaQuery.of(context).size.height,
          width: 450,
          child: TabBarView(children: [
            Column(
              children: slots_feed,
            ),
            Column(
              children: blackjack_feed,
            ),
            Column(children: roulette_feed),
          ]),
        ),
      ],
    ),
  );
}

Column playerItems(String name, String item, String charge,
        {Color oddColour = Colors.white}) =>
    Column(
      children: [
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
              color: oddColour,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  redGreenFont(charge)
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ],
    );

class Leaderboard extends StatefulWidget {
  @override
  _Leaderboard createState() => _Leaderboard();
}

class _Leaderboard extends State<Leaderboard> {
  @override
  void initState() {
    //Prevents Duplicates
    load_feeds();
    super.initState();
    print("Initialized State!");
  }

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
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 110.0),
                Text(user_reference,
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Text('Leaderboards',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                displayAccountList(context),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> load_feeds() async {
    blackjack_feed.clear();
    slots_feed.clear();
    roulette_feed.clear();
    var reqs = {"": ""};
    var feed_raw = await request("GetLeaderboard", reqs, Toast: false);
    if (feed_raw[0] == 200) {
      blackjack_feed = game_extract(feed_raw[1]["Blackjack"], blackjack: true);
      slots_feed = game_extract(feed_raw[1]["Slots"]);
      roulette_feed = game_extract(feed_raw[1]["Roulette"]);
    }
    setState(() {});
  }
}

List<Widget> game_extract(List<dynamic>? feed, {bool blackjack: false}) {
  if (feed == null) {
    return [Container()];
  }
  List<Widget> ret_list = <Widget>[];

  for (var object in feed) {
    var bet = "Bet: " + r'$' + object["bet"].toString();
    var winnings = "Game Refunded";
    if (blackjack) {
      if (object["active"]) {
        winnings = "Game In Progress";
      } else {
        winnings = "Game Refunded";
      }
    }

    if (object["winnings"] != null) {
      final oCcy = new NumberFormat("#,##0.00", "en_US");
      winnings = r"$" + (oCcy.format(object["winnings"] - object["bet"]));
    }
    String name = object["username"];
    ret_list.add(playerItems(name,bet,winnings));
  }
  return ret_list;
}