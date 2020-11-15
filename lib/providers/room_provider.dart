import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:embesys_ctrl/models/page_model.dart';
import 'package:embesys_ctrl/providers/base_provider.dart';
import 'package:flutter/cupertino.dart';

class RoomProvider extends BaseProvider {
  PageController _pageController = PageController();
  List<PageModel> _pages = [
    PageModel('Living Room', true, livingRoom),
    PageModel('Kitchen', false, kitchen),
    PageModel('Family Room', false, familyRoom),
    PageModel('Entertainment Room', false, entertainmentRoom),
  ];

  PageController get pageController => _pageController;
  List<PageModel> get pages => _pages;

  void updatePage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    _pages.forEach((element) {
      element.isSelected = false;
    });
    _pages[index].isSelected = true;
    notifyListeners();
  }

  Future toggleLed(int index, int i, {bool state = true}) async {
    String val;
    if (state) {
      val = "ON";
    } else {
      val = "OFF";
    }
    Map res = await networkRepository.toggleLed(_pages[i].modules[index].route,
        state: val);
    log(res.toString());
    switch (res['type']) {
      case 'success':
        if (val == "ON")
          _pages[i].modules[index].isOn = false;
        else
          _pages[i].modules[index].isOn = true;
        notifyListeners();
        print('success');
        break;
      default:
        log('There was a problem: ${res['type']}');
    }
  }

  Future toggleSocketLed(int index, int i, {bool state = true}) async {
    String val;
    if (state) {
      val = "ON";
    } else {
      val = "OFF";
    }
    String key = _pages[i].modules[index].key;
    Map res = await networkRepository.socketLed({key: state ? 1 : 0});
    log(res.toString());
    switch (res['type']) {
      case 'success':
        if (val == "ON")
          _pages[i].modules[index].isOn = false;
        else
          _pages[i].modules[index].isOn = true;
        notifyListeners();
        print('success');
        break;
      default:
        log('There was a problem: ${res['type']}');
    }
  }
}
