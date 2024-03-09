import 'package:flutter/material.dart';
import 'package:front_end/color-palette.dart';
import 'package:front_end/account-login.dart';
import 'package:front_end/depo-withdraw.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item,
                        fit: BoxFit.cover, width: double.infinity),
                  ],
                )),
          ),
        ))
    .toList();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cooper Casino',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      home: MyHomePage(title: 'Cooper Casino Home Page'),
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
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(autoPlay: true, height: 500),
                carouselController: _controller,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text('BLACKJACK',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()))),
                TextButton(
                    child: Text('ROULETTE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new AccountLogin()))),
                TextButton(
                    child: Text('SLOTS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new DepoWithdraw()))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: IconButton(
                    onPressed: () => _controller.previousPage(),
                    icon: Icon(Icons.navigate_before,
                        color: Colors.white,
                        size: 40.0,
                        semanticLabel: 'Navigate Left'),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () => _controller.nextPage(),
                    icon: Icon(Icons.navigate_next,
                        color: Colors.white,
                        size: 40.0,
                        semanticLabel: 'Navigate Right'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
