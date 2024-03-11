import 'package:flutter/material.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/home.dart';
import 'package:front_end/main.dart';
import 'package:front_end/color-palette.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }
}
