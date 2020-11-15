import 'package:flutter/material.dart';

class ModulesModel {
  IconData icon;
  bool isOn;
  String title;
  String subTitle;
  String route;
  String key;

  ModulesModel({
    this.icon,
    this.isOn,
    this.title,
    this.subTitle,
    this.route = "/",
    this.key = "",
  });
}
