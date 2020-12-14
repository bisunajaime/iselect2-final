import 'package:embesys_finals/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifs = [];

  addNotif(NotificationModel notif) {
    _notifs.add(notif);
    notifyListeners();
  }
}
