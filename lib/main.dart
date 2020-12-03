import 'dart:convert';
import 'dart:math';

import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/pages/home_page.dart';
import 'package:embesys_ctrl/providers/room_provider.dart';
import 'package:embesys_ctrl/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoomProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CTRL - Things Anywhere',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
            headline2: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            headline3: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            headline4: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/intro_screen.png',
                alignment: Alignment.center,
                scale: 3,
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/images/splash.png',
                alignment: Alignment.center,
                scale: 4,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return HomePage();
                          },
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    color: boxGrad.colors[1],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // TestWebSocket(),
            ],
          ),
        ),
      ),
    );
  }
}

// class TestWebSocket extends StatefulWidget {
//   @override
//   _TestWebSocketState createState() => _TestWebSocketState();
// }

// class _TestWebSocketState extends State<TestWebSocket> {
//   IOWebSocketChannel channel;

//   void connectToSocket() async {
//     channel = IOWebSocketChannel.connect("ws://192.168.254.117:81/");
//     channel.stream.listen((message) {
//       // channel.sink.add("received!");
//       print(message);
//       // channel.sink.close(status.goingAway);
//     });
//   }

//   void sendData() async {
//     int r = Random().nextInt(2);

//     int d = Random().nextInt(2);
//     print(r);
//     try {
//       channel.sink.add(jsonEncode({
//         "LED1": r,
//         "LED2": d,
//       }));
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   @override
//   void initState() {
//     connectToSocket();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: FlatButton(
//               onPressed: () async {
//                 connectToSocket();
//                 // sendData();
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(
//                 'Reconnect',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//               color: boxGrad.colors[1],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: FlatButton(
//               onPressed: () async {
//                 // connectToSocket();
//                 sendData();
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(
//                 'Test WebSocket',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//               color: boxGrad.colors[1],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32),
//           child: SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: FlatButton(
//               onPressed: () async {
//                 // connectToSocket();
//                 // sendData();
//                 channel.sink.close();
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Text(
//                 'Close WebSocket',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//               color: boxGrad.colors[1],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
