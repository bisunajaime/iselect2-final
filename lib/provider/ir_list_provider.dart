import 'package:embesys_finals/models/categories_model.dart';
import 'package:embesys_finals/models/ir_model.dart';
import 'package:flutter/material.dart';

class IRListProvider extends ChangeNotifier {
  List<IRModel> _irRecvList = [];
  List<CategoriesModel> _categories = [];

  List<IRModel> get irRecvList => _irRecvList;
  List<CategoriesModel> get categories => _categories;

  addCategory(CategoriesModel category) {
    Iterable<CategoriesModel> hasDuplicate = _categories.where(
        (element) => element.name.toLowerCase() == category.name.toLowerCase());

    if (hasDuplicate.toList().length == 0) {
      print('added categry');
      _categories.add(category);
      notifyListeners();
    }
    print(_categories.length);
  }

  addIRData(IRModel val) {
    if (val.value == "ffffffff") {
      return;
    }
    Iterable<IRModel> hasDuplicate =
        _irRecvList.where((element) => element.value == val.value);
    if (hasDuplicate.toList().length == 0) {
      _irRecvList.add(val);
      notifyListeners();
    }
    print("LEN: ${_irRecvList.length}");
  }

  deleteIRData(int index) {
    IRModel toBeDeleted = _irRecvList[index];
    Iterable<CategoriesModel> found =
        _categories.where((element) => element.name == toBeDeleted.category);
    if (found.toList().length != 0) {
      found.toList()[0].buttonCount--;
    }
    _irRecvList.removeAt(index);

    notifyListeners();
  }

  updateLabel(
      int index, String label, int categoryIndex, int prevCategoryIndex) {
    if (label == null) return;
    IRModel val = _irRecvList[index];
    if (val.category != null) {
      if (val.category == _categories[categoryIndex].name) {
        return;
      } else {
        // subtract 1 to prev category
        _categories[prevCategoryIndex].buttonCount--;
      }
    }
    val.label = label;
    val.category = _categories[categoryIndex].name;
    // add 1 to new categry
    _categories[categoryIndex].buttonCount++;
    notifyListeners();
  }
}
