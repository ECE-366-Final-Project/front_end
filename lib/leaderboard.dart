import 'package:flutter/material.dart';
import 'package:front_end/generics.dart';

var feed = <Widget>[
  accountItems(r"+ $ 4,946.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"+ $ 5,428.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"- $ 746.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"- $ 4,526.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"+ $ 0.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"+ $ 4,946.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"+ $ 5,428.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"- $ 746.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"- $ 4,526.00", "Bet:" + r"$ 4,946.00"),
  accountItems(r"+ $ 0.00", "Bet:" + r"$ 4,946.00"),
];

greenFont(String charge) {
  return Text(charge,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green));
}

displayAccoutList() {
  return Container(
    width: 400,
    child: Column(children: feed),
  );
}

Column accountItems(String charge, String type,
        {Color oddColour = Colors.white}) =>
    Column(
      children: [
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
                  Text(user_reference,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  greenFont(charge)
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
        SizedBox(height: 10.0),
      ],
    );

class Leaderboard extends StatefulWidget {
  @override
  _Leaderboard createState() => _Leaderboard();
}

class _Leaderboard extends State<Leaderboard> {
  @override
  void initState() {
    super.initState();
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
                SizedBox(height: 50.0),
                Text(
                  'Roulette Leaderboard',
                  style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () => {
                          setState(() {
                            feed.removeAt(0);
                            feed.add(accountItems(r"+ $ 0.00", "Credit"));
                          })
                        },
                    icon: Icon(Icons.refresh,
                        color: Colors.white,
                        size: 30.0,
                        semanticLabel: 'Refresh History')),
                SizedBox(height: 20.0),
                displayAccoutList(),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
