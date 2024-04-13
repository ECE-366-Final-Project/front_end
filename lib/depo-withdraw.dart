import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:front_end/generics.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

var currencyValue = new NumberFormat.compact();

class DepoWithdraw extends StatefulWidget {
  const DepoWithdraw({Key? key}) : super(key: key);

  @override
  State<DepoWithdraw> createState() => _DepoWithdrawState();
}

class _DepoWithdrawState extends State<DepoWithdraw> {
  String depoWithText = '0.00';
  String tempBalance = '';
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
        appBar: App_Bar(context),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100.0),
            Text('\$' + balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + depoWithText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Deposit',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async{
                  Deposit(depoWithText);
                  setState(() async {
                    balance = await balanceUpdate();
                  });
                },
              ),
              SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Withdrawal',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async{
                  Withdraw(depoWithText);
                  setState(() async {
                    balance = await balanceUpdate();
                  });
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                tempBalance =
                    tempBalance + currencyValue.format(double.parse(value));
                setState(() {
                  depoWithText = tempBalance;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (depoWithText.isEmpty ||
                    depoWithText == '0.00' ||
                    depoWithText == '-0.00') return;
                setState(() {
                  depoWithText =
                      depoWithText.substring(0, depoWithText.length - 1);
                  tempBalance = depoWithText;
                  if (depoWithText.isEmpty ||
                      depoWithText == '0.00' ||
                      depoWithText == '-0.00') {
                    depoWithText = '0.00';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (depoWithText.isEmpty) return;
                setState(() {
                  depoWithText = '0.00';
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
  
  void Withdraw(String depoWithText) {
    request("Withdraw", {"token" :sessiontoken, "amount": depoWithText});
  }
  
  void Deposit(String depoWithText) {
    request("Deposit", {"token" :sessiontoken, "amount": depoWithText});
  }
}
