import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/slot-machine.dart';

var currencyValue = new NumberFormat.compact();
String slotBetText = "0.00";
String slotTempBalance = "";
bool play = false;

class Slots extends StatefulWidget {
  const Slots({Key? key}) : super(key: key);
  @override
  _SlotsState createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  late SlotMachineController _controller;

  @override
  void initState() {
    super.initState();
  }

  void onStart(List<int> result) {
    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 5 ? index : null, result: result);
    Timer(Duration(seconds: 3), () {
      _controller.stop(reelIndex: 0);
    });
    Timer(Duration(seconds: 6), () {
      _controller.stop(reelIndex: 1);
    });
    Timer(Duration(seconds: 9), () {
      _controller.stop(reelIndex: 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooper Casino',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData().copyWith(
          scaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
          splashColor: Colors.white,
          focusColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.white)),
      home: Scaffold(
        appBar: App_Bar(context),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100.0),
            SlotMachine(
                rollItems: [
                  RollItem(
                      index: 0,
                      child:
                          img_getter('assets/sprites/slots-symbols/1xbar.png')),
                  RollItem(
                      index: 1,
                      child:
                          img_getter('assets/sprites/slots-symbols/2xbar.png')),
                  RollItem(
                      index: 2,
                      child:
                          img_getter('assets/sprites/slots-symbols/3xbar.png')),
                  RollItem(
                      index: 3,
                      child: img_getter(
                          'assets/sprites/slots-symbols/cherry.png')),
                  RollItem(
                      index: 4,
                      child: img_getter(
                          'assets/sprites/slots-symbols/clover.png')),
                  RollItem(
                      index: 5,
                      child:
                          img_getter('assets/sprites/slots-symbols/lemon.png')),
                  RollItem(
                      index: 6,
                      child:
                          img_getter('assets/sprites/slots-symbols/seven.png')),
                  RollItem(
                      index: 7,
                      child:
                          img_getter('assets/sprites/slots-symbols/bell.png')),
                  RollItem(
                      index: 8,
                      child:
                          img_getter('assets/sprites/slots-symbols/gem.png')),
                  RollItem(
                      index: 9,
                      child: img_getter(
                          'assets/sprites/slots-symbols/jackpot_style_2.png')),
                ],
                onCreated: (controller) {
                  _controller = controller;
                },
                onFinished: (resultIndexes) {
                  print('Result: $resultIndexes');
                }),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + balance,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text('\$' + slotBetText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Play',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  //TODO: Make this one function call, no logic should be completed in this area
                  var roll_data = await Play_Slots(double.parse(slotBetText));
                  if (roll_data[0] == 200) {
                    String roll_reference = roll_data[1]["PAYOUT_ID"].toString();
                    //Straightens string to ensure that it works fine, then converts it to an integer
                    List<int> roll_labels = [];
                    for(var string_roll in roll_reference.padLeft(3,"0").split('')) {
                      roll_labels.add(int.parse(string_roll));
                    }
                  String newbal = await balanceUpdate();                    //
                    onStart(roll_labels);
                    output_roll_data(roll_data,double.parse(slotBetText));
                    //after 
                      setState(() {
                    balance = newbal;
                  });
                  }
                },
              ),
              SizedBox(width: 20.0),
              TextButton(
                style: ButtonStyle(backgroundColor: DWPalette()),
                child: Text('Clear',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  setState(() {
                    slotBetText = "0.00";
                    slotTempBalance = '';
                  });
                },
              ),
            ]),
            NumericKeyboard(
              onKeyboardTap: (String value) {
                slotTempBalance =
                    slotTempBalance + currencyValue.format(double.parse(value));
                setState(() {
                  slotBetText = slotTempBalance;
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              rightButtonFn: () {
                if (slotBetText.isEmpty ||
                    slotBetText == '0.00' ||
                    slotBetText == '-0.00') return;
                setState(() {
                  slotBetText =
                      slotBetText.substring(0, slotBetText.length - 1);
                  slotTempBalance = slotBetText;
                  if (slotBetText.isEmpty ||
                      slotBetText == '0.00' ||
                      slotBetText == '-0.00') {
                    slotBetText = '0.00';
                    slotTempBalance = '';
                  }
                });
              },
              rightButtonLongPressFn: () {
                if (slotBetText.isEmpty) return;
                setState(() {
                  slotBetText = '0.00';
                  slotTempBalance = '';
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

  Image img_getter(String path) {
    return Image.asset(path);
  }

  Future<List> Play_Slots(double bet) async {
    var reqs = {"token": sessiontoken, "bet": bet.toString()};
    var data = await request("PlaySlots", reqs, Toast: false);
    return data;
  }
}

void output_roll_data(List roll_data, double bet) {
  var Json = roll_data[1];
  var winnings = Json["WINNINGS"];
  var col_str = "linear-gradient(to right, #00b09b, #96c93d)";
  var msg = "You won \$" + winnings.toStringAsFixed(2) + "!";
  if(winnings < bet) {
      msg = "You won \$" + winnings.toStringAsFixed(2) + ". Better luck next time!";
      col_str = "linear-gradient(to right, #ced111, #ced111)";
  }  
Future.delayed(Duration(seconds: 10), () {
       Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
        webPosition: "center",
        webBgColor: col_str,
        fontSize: 40);
  // Do something
});

 
}
