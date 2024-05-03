import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_end/depowith-palette.dart';
import 'package:intl/intl.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/generics.dart';
import 'package:flutter/gestures.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flip_card/flip_card.dart';

var currencyValue = new NumberFormat.compact();
String bj_bet_text = "0.00";
String slotTempBalance = "";
bool play = false;
FlipCardController _controller = FlipCardController();
ScrollController _scrollController = ScrollController();
String backOfCard = 'sprites/cards/face-pngs/Playing_Card_Back.jpg';

List<Image> dealerCards = [];
List<Image> playerCards = [];
List<String> playerString = [];
List<Widget> renderDealCards = [];
List<Widget> renderPlayerCards = [];
List<String> dealerString = [];

cardAdd(List<Image> imageDeck, List<Widget> displayDeck, String face) async {
  imageDeck.add(Image.asset(face));
  // displayDeck.add(const SizedBox(width: 5.0));
  // displayDeck.add(card(imageDeck[imageDeck.length - 1]));
  Widget Card = coverCard(face);
  displayDeck.add( const SizedBox(width: 5.0,));
  displayDeck.add(Card);
  await Future.delayed(Duration(seconds: 1));
}

clearDeck() {
  dealerCards.clear();
  playerCards.clear();
  renderDealCards.clear();
  renderPlayerCards.clear();
  playerString.clear();
  dealerString.clear();
}

FlipCard coverCard(String cardFace) {
  return FlipCard(
      controller: _controller,
      flipOnTouch: false,
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      back: SizedBox(
        height: 111.25,
        width: 81.25,
        child: Image.asset(fit: BoxFit.fill, cardFace),
      ),
      front: SizedBox(
        height: 111.25,
        width: 81.25,
        child: Image.asset(
            fit: BoxFit.fill, backOfCard),
      ),
      autoFlipDuration: const Duration(seconds: 1));
}

SizedBox card(Image face) {
  return SizedBox(height: 111.25, width: 81.25, child: face);
}

SizedBox cardItems(List<Widget> renderCards) {
  List<Widget> render_children = List.from(renderCards);
  if(renderCards.length <= 2) {
      render_children.add(const SizedBox(width: 5.0));
      render_children.add(card(Image.asset(backOfCard)));
  }
  return SizedBox(
    width: 345,
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center, children: render_children),
      ),
    ),
  );
}

class Blackjack extends StatefulWidget {
  const Blackjack({Key? key}) : super(key: key);
  @override
  _BlackjackState createState() => _BlackjackState();
}

class _BlackjackState extends State<Blackjack> {
  @override
  void initState() {
    super.initState();
    renderDealCards.add(const SizedBox(width: 5.0));
    renderPlayerCards.add(const SizedBox(width: 5.0));
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
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      home: Scaffold(
        appBar: App_Bar(context),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 100.0),
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
            Text('\$' + bj_bet_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            !play
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Play',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        var curtime = DateTime.now();
                        if (ratelimit.difference(curtime).inSeconds > 10) {
                          var col_str =
                              "linear-gradient(to right, #ced111, #ced111)";
                          Fluttertoast.showToast(
                              msg: "Please slow down your queries",
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.black,
                              // webPosition: "center", // :3 I Was here
                              webBgColor: col_str,
                              fontSize: 40);
                          return;
                        }
                        ratelimit = curtime;
                        var payload =
                            await StartBlackjack(double.parse(bj_bet_text));
                        if (payload[0] < 400) {
                          setState(() {
                            play = true;
                          });
                        }
                      },
                    ),
                    SizedBox(width: 20.0),
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Clear',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          clearDeck();
                          bj_bet_text = "0.00";
                          slotTempBalance = '';
                        });
                      },
                    ),
                    SizedBox(width: 20.0),
                    TextButton(
                      style: ButtonStyle(backgroundColor: DWPalette()),
                      child: Text('Rejoin Game',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        var payload = await RejoinBlackjack();
                        if (payload[0] < 400) {
                          setState(() {
                            play = true;
                          });
                        }
                      },
                    )
                  ])
                : SingleChildScrollView(
                    child: Column(
                      children: [],
                    ),
                  ),
            !play
                ? NumericKeyboard(
                    onKeyboardTap: (String value) {
                      slotTempBalance = slotTempBalance +
                          currencyValue.format(double.parse(value));
                      setState(() {
                        bj_bet_text = slotTempBalance;
                      });
                    },
                    mainAxisAlignment: MainAxisAlignment.center,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                    rightButtonFn: () {
                      if (bj_bet_text.isEmpty ||
                          bj_bet_text == '0.00' ||
                          bj_bet_text == '-0.00') return;
                      setState(() {
                        bj_bet_text =
                            bj_bet_text.substring(0, bj_bet_text.length - 1);
                        slotTempBalance = bj_bet_text;
                        if (bj_bet_text.isEmpty ||
                            bj_bet_text == '0.00' ||
                            bj_bet_text == '-0.00') {
                          bj_bet_text = '0.00';
                          slotTempBalance = '';
                        }
                      });
                    },
                    rightButtonLongPressFn: () {
                      if (bj_bet_text.isEmpty) return;
                      setState(() {
                        bj_bet_text = '0.00';
                        slotTempBalance = '';
                      });
                    },
                    rightIcon: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.white,
                    ),
                  )
                : Container(),
            SizedBox(height: 20.0),
            const SizedBox(height: 20.0),
            cardItems(renderDealCards),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 81.25,
              width: 111.25,
              child: Image.asset(
                  fit: BoxFit.fill,
                  'sprites/cards/face-pngs/Rotated_Card_Back.gif'),
            ),
            const SizedBox(height: 40.0),
            cardItems(renderPlayerCards),
            const SizedBox(height: 20.0),
            play ?
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  icon: const Icon(Icons.add_circle_rounded,
                      color: Colors.green, size: 40.0, semanticLabel: 'Hit'),
                  onPressed: () async {
                    bool data = await blackjack_call("hit");
                    State_Setter(data);
                  }),
              IconButton(
                  icon: const Icon(Icons.stop_circle_rounded,
                      color: Colors.red, size: 40.0, semanticLabel: 'Stand'),
                  onPressed: () async {
                    bool data = await blackjack_call("stand");
                    State_Setter(data);
                  }),
              IconButton(
                  icon: const Icon(Icons.exposure_plus_2_rounded,
                      color: Colors.green,
                      size: 40.0,
                      semanticLabel: 'Double Down'),
                  onPressed: () async {
                    bool data = await blackjack_call("double_down");

                    State_Setter(data);
                  }),
            ]) : Container(),
            SizedBox(height: 100.0)
          ]),
        ),
      ),
    );
  }

  Future<void> State_Setter(bool game_running) async {
    var temp_bal = await balanceUpdate();
    if (!game_running) {
      await Future.delayed(Duration(seconds: 5), () {
          setState(() {
          balance = temp_bal;
          play = game_running;
      });
      });
    } else {
      setState(() {
        play = game_running;
      });
    }
  }

  Future<void> render(var json) async {
    var new_player_cards = card_parser(json["PLAYERS_CARDS"]);
    var new_dealer_cards = card_parser(json["DEALERS_CARDS"]);
      for (String card in new_player_cards) {
        if (!playerString.contains(card)) {
          playerString.add(card);
          String card_path = "sprites/cards/face-pngs/" + card + ".png";
          await cardAdd(playerCards, renderPlayerCards, card_path);
        }
      }
      for (String card in new_dealer_cards) {
        if (!dealerString.contains(card)) {
          dealerString.add(card);
          String card_path = "sprites/cards/face-pngs/" + card + ".png";
          await cardAdd(dealerCards, renderDealCards, card_path);
        }
      }

    setState(() {});
    await Future.delayed(Duration(seconds: 3));
    if (json["GAME_ENDED"] == "true") {
      Fluttertoast.showToast(
          msg: "Game over! Winner: " + json["WINNER"],
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.black,
          webPosition: "center",
          fontSize: 40,
          timeInSecForIosWeb: 10);
    }
  }

  Future<bool> blackjack_call(String s) async {
    var reqs = {"token": sessiontoken, "move": s};
    var data = await request("UpdateBlackjack", reqs, Toast: false);
    if (data[0] == 200) {
      render(data[1]);
    }
    print(data[1]["GAME_ENDED"]);
    return (!(data[1]["GAME_ENDED"] == "true"));
  }

  Future<List> RejoinBlackjack() async {
    setState(() {
      clearDeck(); //
    });

    var reqs = {"token": sessiontoken};
    var data = await request("RejoinBlackjack", reqs, Toast: false);
    if (data[0] == 200) {
      render(data[1]);
    }
    return data;
  }

  Future<List> StartBlackjack(double bet) async {
    setState(() {
      clearDeck(); //
    });
    var reqs = {"token": sessiontoken, "bet": bet.toString()};
    var data = await request("NewBlackjack", reqs, Toast: false);
    if (data[0] == 200) {
      render(data[1]);
    } else if (data[0] == 412) {
      return RejoinBlackjack();
    }
    return data;
  }
}

List<String> card_parser(cards) {
  List<String> card_data = [];
  for (int i = 0; i < cards.length; i += 2) {
    card_data.add(cards.substring(i, i + 2));
  }
  print(card_data);
  return card_data;
}
