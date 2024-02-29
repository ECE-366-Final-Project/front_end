import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
          TextButton(
              child: Text('BLACKJACK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))),
          Text("|",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          TextButton(
              child: Text('SLOTS',
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
