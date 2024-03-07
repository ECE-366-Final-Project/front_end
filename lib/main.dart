import 'package:flutter/material.dart';

enum SampleItem { blackjack, roulette, slots }

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cooper Casino',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
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
  SampleItem? selectedItem;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TextButton(
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
          PopupMenuButton(
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                        child: TextButton(
                            child: Text('BLACKJACK'),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp())))),
                    PopupMenuItem<SampleItem>(
                        child: TextButton(
                            child: Text('ROULETTE'),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp())))),
                    PopupMenuItem<SampleItem>(
                        child: TextButton(
                            child: Text('SLOTS'),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp())))),
                  ]),
          Text("|",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          TextButton(
              child: Text('BALANCE',
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
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
