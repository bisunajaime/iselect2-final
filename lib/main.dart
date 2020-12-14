import 'package:embesys_finals/pages/enter_ip_page.dart';
import 'package:embesys_finals/provider/ir_list_provider.dart';
import 'package:embesys_finals/provider/notification_provider.dart';
import 'package:embesys_finals/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: UiColors.secondaryColor,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IRListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Embesys - Finals',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: EnterIPPage(),
      ),
    );
  }
}
