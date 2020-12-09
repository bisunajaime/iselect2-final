import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String _deviceId = "";
  Future initialise() async {
    _fcm.getToken().then((value) => (setState(() => _deviceId = value)));
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        log(message.toString());
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Notification'),
              content: Text('There was a notification.'),
              actions: [
                FlatButton(
                  child: Text('Dismiss'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(height: 8),
              Image.asset(
                'assets/images/intro_screen.png',
                alignment: Alignment.center,
                scale: 3,
              ),
              SizedBox(height: 8),
              Image.asset(
                'assets/images/splash.png',
                alignment: Alignment.center,
                scale: 4,
              ),
              Text(
                'Ctrl your devices anywhere.',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Enter your username and password below.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // Toggle visibility
                    },
                    child: Icon(
                      Icons.visibility_off,
                    ),
                  ),
                  fillColor: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  child: Text('Login'),
                  color: boxGrad.colors[1],
                  onPressed: () {
                    // login
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
