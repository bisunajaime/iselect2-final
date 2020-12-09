import 'dart:convert';
import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/home_page.dart';
import 'package:embesys_ctrl/providers/login_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _deviceId = "";
  final _formKey = GlobalKey<FormState>();
  bool _showPass = true;
  Future initialise() async {
    _fcm.getToken().then((value) {
      print(value);
      setState(() {
        _deviceId = value;
      });
    });
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        log(message.toString());
        final notification = message['notification'];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(notification['title']),
              content: Text(notification['body']),
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
    final provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Image.asset(
                      'assets/images/intro_screen.png',
                      alignment: Alignment.center,
                      scale: 3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ctrl your devices anywhere.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
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
                    controller: _username,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(.05),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _showPass,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        child: Icon(
                          !_showPass ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      fillColor: Colors.black.withOpacity(.05),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  provider.busy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: boxGrad.colors[1],
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              bool response = await provider.login(
                                username: _username.text,
                                password: _password.text,
                                deviceId: _deviceId,
                              );
                              if (response) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('There was a problem'),
                                    content: Text(
                                        'Username or password is incorrect. Please try again.'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Dismiss'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
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
        ),
      ),
    );
  }
}
