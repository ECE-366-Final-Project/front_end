import 'package:flutter/material.dart';
import 'package:front_end/main.dart';
import 'package:front_end/color-palette.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton(
            child: Text('♤♡ COOPER CASINO ♢♧',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()))),
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
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
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
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[],
      ),
    );
  }
}
