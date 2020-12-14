import 'package:embesys_finals/models/ir_model.dart';
import 'package:flutter/material.dart';

class IRListProvider extends ChangeNotifier {
  List<IRModel> _irRecvList = [];

  List<IRModel> get irRecvList => _irRecvList;

  addIRData(IRModel val) {
    IRModel hasDuplicate =
        _irRecvList.where((element) => element.value != val.value).toList()[0];
    print(hasDuplicate);
    // ...
    // _irRecvList.add(val);
    notifyListeners();
  }

  deleteIRData(int index) {
    _irRecvList.removeAt(index);
    notifyListeners();
  }

  updateLabel(int index, String label) {
    IRModel val = _irRecvList[index];
    val.label = label;
    notifyListeners();
  }
}
