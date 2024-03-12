import 'package:flutter/material.dart';
// import '../utils/account.dart';
// import '../utils/blackjack.dart';
import "appbar.dart";
// Hard Coding user data for now
//TODO: Integrate login
String userID = '00';
void main() => runApp(new MyApp());

final globtheme = new ThemeData(scaffoldBackgroundColor: const Color(0xFF000000));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: globtheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBar_get(context),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
