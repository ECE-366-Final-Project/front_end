import 'package:flutter/material.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/account-login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

List<Widget> account_feed = <Widget>[];
List<Widget> blackjack_feed = <Widget>[];
List<Widget> roulette_feed = <Widget>[];
List<Widget> slots_feed = <Widget>[];

redGreenFont(String type, String charge) {
  if (charge[0] + charge[1] == r"$-" || type == "WITHDRAWAL") {
    return Text(charge,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red));
  } else if (charge[0] == r"$" || type == "DEPOSIT") {
    return Text(charge,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green));
  }
 else {
    return Text(charge,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
  }
}

displayAccountList(BuildContext context) {
  return DefaultTabController(
    length: 4,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 500,
          child: TabBar(tabs: [
            Tab(text: "User"),
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
              children: account_feed,
            ),
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

Column accountItems(String item, String charge, String type,
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
                  redGreenFont(item, charge)
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(type,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
        ),
      ],
    );

class Account extends StatefulWidget {
  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  @override
  void initState() {
    //Prevents Duplicates
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
                Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/login_logo.png')),
                ),
                SizedBox(height: 40.0),
                TextButton(
                    child: Text('\$' + balance,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepoWithdraw()))),
                SizedBox(height: 20.0),
                Text('TRANSACTION & GAME HISTORY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                IconButton(
                    onPressed: () async {
                      balance = '0.00';
                      sessiontoken = "";
                      final prefs = await SharedPreferences.getInstance();
                      print("This is the token!");
                      print(prefs.getString('token'));
                      await prefs.remove('token');
                      user_reference = "";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountLogin()));
                    },
                    icon: Icon(Icons.logout_rounded,
                        color: Colors.white,
                        size: 30.0,
                        semanticLabel: 'Refresh History')),
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
}

Future<void> load_feeds() async {
  blackjack_feed.clear();
  slots_feed.clear();
  roulette_feed.clear();
  account_feed.clear();

  var reqs = {"token": sessiontoken};
  var feed_raw = await request("GetUserHistory", reqs, Toast: false);
  if (feed_raw[0] == 200) {
    blackjack_feed = game_extract(feed_raw[1]["Blackjack"]);
    slots_feed = game_extract(feed_raw[1]["Slots"]);
    roulette_feed = game_extract(feed_raw[1]["Roulette"]);
    account_feed = transaction_extract(feed_raw[1]["Transactions"]);
  }
}

List<Widget> game_extract(List<dynamic>? feed) {
  if (feed == null) {
    return [Container()];
  }
  List<Widget> ret_list = <Widget>[];

  for (var object in feed) {
    var bet = "Bet: " + r'$' + object["bet"].toString();
    var winnings = "Game in Progress";
    if (object["winnings"] != null) {
      winnings = r"$" + (object["winnings"] - object["bet"]).toString();
    }
    var time_label = DateTime.parse(object["time"]).toLocal();
    var formatted_time = DateFormat("MM-dd-yyyy - hh:mm a").format(time_label);
    ret_list.add(accountItems(bet, winnings, formatted_time));


    print(object);
  }
  return ret_list;

}

List<Widget> transaction_extract(List<dynamic>? feed) {
  if (feed == null) {
    return [Container()];
  }
  List<Widget> ret_list = <Widget>[];
  //This is the datadump of all 5 latest transactions for each category.
  for (var object in feed) {
    var time_label = DateTime.parse(object["time"]).toLocal();
    var formatted_time = DateFormat("MM-dd-yyyy - hh:mm a").format(time_label);
    ret_list.add(accountItems(object["transaction_type"],
        r"$" + object["amount"].toString(), formatted_time));
  }
  return ret_list;
}