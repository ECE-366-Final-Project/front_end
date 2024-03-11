import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class Slots_Home extends StatelessWidget {
  Slots_Home({Key? key, required this.title, required this.userID, required this.theme}) : super(key: key);
  final String title;
  final String userID;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slots main page',
      theme: this.theme,
      home: Slots_Frontend(),
    );
  }

}

class Slots_Frontend extends StatefulWidget {
  @override
  State<Slots_Frontend> createState() => _Slots_State();
}

class _Slots_State extends State<Slots_Frontend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}



  Future<http.Response> play(String api_host, String userID, String bet) {
    final params = {
      "userID": userID,
       "bet": bet,
    };
    // This is the call that needs to be made
    final data = Uri.http(api_host,"/PlaySlots",params);
    return http.get(data);
    }
