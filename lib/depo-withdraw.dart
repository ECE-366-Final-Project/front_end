import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:front_end/account.dart';
import 'package:front_end/home.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

String originalBalance = '0.00';
String text = '0.00';
String tempBalance = '';
var currencyValue = new NumberFormat.compact();

class DepoWithdraw extends StatefulWidget {
  const DepoWithdraw({Key? key}) : super(key: key);

  @override
  State<DepoWithdraw> createState() => _DepoWithdrawState();
}

class _DepoWithdrawState extends State<DepoWithdraw> {
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100.0),
            Text('\$' + text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Deposit',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (double.parse(text) < 0) {
                    setState(() {
                      text = (double.parse(text) * -1).toString();
                    });
                  } else {
                    text = (double.parse(originalBalance) + double.parse(text))
                        .toString();
                  }
                },
              ),
              SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Withdrawal',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (double.parse(text) > 0) {
                    setState(() {
                      text = (double.parse(text) * -1).toString();
                    });
                  } else {
                    text = (double.parse(originalBalance) - double.parse(text))
                        .toString();
                  }
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                tempBalance =
                    tempBalance + currencyValue.format(double.parse(value));
                setState(() {
                  text = tempBalance;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (text.isEmpty || text == '0.00' || text == '-0.00') return;
                setState(() {
                  text = text.substring(0, text.length - 1);
                  tempBalance = text;
                  if (text.isEmpty || text == '0.00' || text == '-0.00') {
                    text = '0.00';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (text.isEmpty) return;
                setState(() {
                  text = '0.00';
                });
              },
              rightIcon: const Icon(
                Icons.backspace_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }
}