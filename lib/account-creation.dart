import 'package:flutter/material.dart';
import 'package:front_end/account-login.dart';

class AccountCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('COOPER CASINO',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('lib/assets/images/login_logo.png')),
            ),
          ),
          SizedBox(height: 40),
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            child: SizedBox(
              width: 350,
              child: TextField(
                style: TextStyle(
                    color: Colors.white, decorationColor: Colors.white),
                cursorColor: Colors.white,
                cursorErrorColor: Colors.red,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter your username'),
              ),
            ),
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: SizedBox(
              width: 350,
              child: TextField(
                cursorColor: Colors.white,
                obscureText: true,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountLogin()));
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
            child: Text('Create an Account',
                style: TextStyle(color: Colors.white)),
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountCreation()))
            },
          )
        ],
      )),
    );
  }
}
