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
}
