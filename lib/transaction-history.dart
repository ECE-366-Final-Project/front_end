import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/home.dart';
import 'package:front_end/color-palette.dart';

var feed = <Widget>[
  accountItems("Slots", r"+ $ 4,946.00", "Win"),
  accountItems("Transaction", r"+ $ 5,428.00", "Deposit"),
  accountItems("Transaction", r"- $ 746.00", "Withdrawal"),
  accountItems("Blackjack", r"- $ 4,526.00", "Loss"),
  accountItems("Action", r"+ $ 0.00", "Credit"),
];

redGreenFont(String type, String charge) {
  if (type == "Win" || type == "Deposit") {
    return Text(charge,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green));
  } else if (type == "Loss" || type == "Withdrawal") {
    return Text(charge,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.red));
  } else {
    return Text(charge,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
  }
}

displayAccoutList() {
  return Container(
    width: 400,
    child: Column(children: feed),
  );
}

Column accountItems(String item, String charge, String type,
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
                  Text(item,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  redGreenFont(type, charge)
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

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistory createState() => _TransactionHistory();
}

class _TransactionHistory extends State<TransactionHistory> {
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton(
              child: Text('COOPER CASINO',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))),
          backgroundColor: const Color(0xFF000000),
          elevation: 0,
          actions: [
            MenuAnchor(
                style: MenuStyle(backgroundColor: ColorPalette()),
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return TextButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      child: Text('GAMES',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold)));
                },
                menuChildren: [
                  TextButton(
                      child: Text('BLACKJACK',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                  TextButton(
                      child: Text('ROULETTE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                  TextButton(
                      child: Text('SLOTS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => {}),
                ]),
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
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Account()))),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                TextButton(
                    child: Text('BALANCE: \$ ' + text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepoWithdraw()))),
                IconButton(
                    onPressed: () => {
                          setState(() {
                            feed.removeAt(0);
                            feed.add(
                                accountItems("Action", r"+ $ 0.00", "Credit"));
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
