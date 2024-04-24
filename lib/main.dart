import 'package:flutter/material.dart';
import 'package:front_end/account-login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:front_end/generics.dart';
import 'package:front_end/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
// ];
final List<String> imgList = [
  'https://media.npr.org/assets/img/2022/07/29/ap21188557258852_wide-dc06630f1c1a82ed0280cdf5b9de3f50f5f4f52a.jpg',
  'https://blog.grosvenorcasinos.com/wp-content/uploads/2018/09/Roulette1.jpg',
  'https://www.crownperth.com.au/getsydmedia/4b5b5bbe-5a2c-47bd-a989-6a6939971661/220815-Crown-Perth-Gaming-Blackjack-1800x1200px-6.jpg?height=1199'
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
      theme: new ThemeData().copyWith(
          scaffoldBackgroundColor: const Color(0xFF000000),
          splashColor: Colors.white,
          focusColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.white)),
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
        title: Text('♤♡ COOPER CASINO ♢♧',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
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
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                      child: const Text(
                      'PLAY NOW!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('token') ?? "";
                      print("This statement is being read");
                      if (token != "") {
                        sessiontoken = token;
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));

                      } else {
                        print("There was no token, sending user to login");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountLogin()));
                      }
                    },
                    ),
                  ),
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
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
