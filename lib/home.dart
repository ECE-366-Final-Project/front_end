import 'package:flutter/material.dart';
import 'package:front_end/account.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/main.dart';
import 'package:front_end/color-palette.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('COOPER CASINO',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
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
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))),
                TextButton(
                    child: Text('ROULETTE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))),
                TextButton(
                    child: Text('SLOTS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))),
              ]),
          Text("|",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          TextButton(
              child: Text('BALANCE: \$',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DepoWithdraw(title: 'Deposit/Withdrawal')))),
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
                  context, MaterialPageRoute(builder: (context) => Account()))),
        ],
      ),
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
                              icon: Image.asset(
                                  'lib/assets/images/card-deck.png',
                                  color: Colors.black,
                                  height: 128.0,
                                  width: 128.0),
                              onPressed: (() => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp())))))),
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
                                    'lib/assets/images/roulette.png',
                                    color: Colors.black,
                                    height: 128.0,
                                    width: 128.0),
                                onPressed: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp())))))),
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
                                    'lib/assets/images/slot-machine.png',
                                    color: Colors.black,
                                    height: 128.0,
                                    width: 128.0),
                                onPressed: (() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp())))))),
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
    );
  }
}
