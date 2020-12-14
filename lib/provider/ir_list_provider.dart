import 'package:embesys_finals/models/ir_model.dart';
import 'package:flutter/material.dart';

class IRListProvider extends ChangeNotifier {
  List<IRModel> _irRecvList = [];

  List<IRModel> get irRecvList => _irRecvList;

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
    _irRecvList.removeAt(index);
    notifyListeners();
  }

  updateLabel(int index, String label) {
    IRModel val = _irRecvList[index];
    val.label = label;
    notifyListeners();
  }
}
