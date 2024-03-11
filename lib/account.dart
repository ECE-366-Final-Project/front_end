import 'package:flutter/material.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:front_end/home.dart';
import 'package:front_end/color-palette.dart';
import 'package:front_end/transaction-history.dart';

class Account extends StatelessWidget {
  @override
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
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 110.0),
                Text('USERNAME',
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('lib/assets/images/login_logo.png')),
                ),
                SizedBox(height: 40.0),
                TextButton(
                    child: Text('\$ ' + '${text}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepoWithdraw()))),
                SizedBox(height: 20.0),
                TextButton(
                    child: Text('TRANSACTION & GAME HISTORY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionHistory()))),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
