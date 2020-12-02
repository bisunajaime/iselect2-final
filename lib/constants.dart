import 'package:embesys_ctrl/models/modules_model.dart';
import 'package:flutter/material.dart';

final String apiUrl = "";

final Color themeColor = Color(0xffFF7058);
final Color scaffoldBgColor = Color(0xffF4FBFF);
final String weatherStackApiKey = "96bb990734c9d77a968178688d502cd3";

final LinearGradient gradient = LinearGradient(
  colors: [
    Color(0xffFFA049),
    Color(0xffFF3D00),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
);

final LinearGradient boxGrad = LinearGradient(
  colors: [
    Color(0xff00B2FF),
    Color(0xff0057FF),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
);

final List<ModulesModel> livingRoom = [
  ModulesModel(
    icon: Icons.lightbulb_outline,
    isOn: true,
    title: 'Light',
    subTitle: 'OPENED',
    route: '/LED_LIVING=',
    key: "LED_LIVING",
  ),
  ModulesModel(
    icon: Icons.ac_unit,
    isOn: true,
    title: 'Thermostat',
    subTitle: 'CLOSED',
    route: '/',
  ),
];

final List<ModulesModel> kitchen = [
  ModulesModel(
    icon: Icons.ac_unit,
    isOn: false,
    title: 'AC',
    subTitle: 'CLOSED',
  ),
  ModulesModel(
    icon: Icons.tv,
    isOn: true,
    title: 'TV',
    subTitle: 'OPENED',
  ),
];

final List<ModulesModel> familyRoom = [
  ModulesModel(
    icon: Icons.ac_unit,
    isOn: true,
    title: 'AC',
    subTitle: 'OPENED',
  ),
  ModulesModel(
    icon: Icons.tv,
    isOn: true,
    title: 'TV',
    subTitle: 'OPENED',
  ),
];

final List<ModulesModel> entertainmentRoom = [
  // ModulesModel(
  //   icon: Icons.router,
  //   isOn: true,
  //   title: 'Router',
  //   subTitle: 'OPENED',
  // ),
  ModulesModel(
    icon: Icons.surround_sound,
    isOn: false,
    title: 'Speakers',
    subTitle: 'CLOSED',
  ),
  ModulesModel(
    icon: Icons.lightbulb_outline,
    isOn: true,
    title: 'Light',
    subTitle: 'CLOSED',
    route: '/LED_ENTERTAINMENT=',
    key: "LED_ENTERTAINMENT",
  ),
];

final List<Map> sampleData = [
  {
    'icon': Icons.router,
    'is_on': true,
    'title': 'Router',
    'subtitle': 'OPENED',
  },
  {
    'icon': Icons.lightbulb_outline,
    'is_on': false,
    'title': 'Light',
    'subtitle': 'CLOSED',
  },
  {
    'icon': Icons.ac_unit,
    'is_on': false,
    'title': 'AC',
    'subtitle': 'CLOSED',
  },
  {
    'icon': Icons.tv,
    'is_on': true,
    'title': 'TV',
    'subtitle': 'OPENED',
  },
];

final List<Map> rooms = [
  {
    'title': 'Living Room',
    'is_selected': true,
  },
  {
    'title': 'Kitchen',
    'is_selected': false,
  },
  {
    'title': 'Family Room',
    'is_selected': false,
  },
  {
    'title': 'Entertainment Room',
    'is_selected': false,
  },
];
