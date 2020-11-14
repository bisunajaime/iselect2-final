import 'package:embesys_ctrl/utils/network_repository.dart';
import 'package:flutter/foundation.dart';

class BaseProvider extends ChangeNotifier {
  NetworkRepository _networkRepository = NetworkRepository();
  bool _busy = false;
  String _errorMsg = "";

  bool get busy => _busy;
  NetworkRepository get networkRepository => _networkRepository;
  String get errorMsg => _errorMsg;

  void updateBusy(bool isBusy) {
    _busy = isBusy;
    notifyListeners();
  }

  void updateErrorMsg(String message) {
    _errorMsg = message;
    notifyListeners();
  }
}
