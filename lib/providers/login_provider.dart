import 'package:embesys_ctrl/providers/base_provider.dart';
import 'package:flutter/material.dart';

class LoginProvider extends BaseProvider {
  Future<bool> login({
    String username,
    String password,
    String deviceId,
  }) async {
    updateBusy(true);
    Map response = await networkRepository.login(
      username: username,
      password: password,
      deviceId: deviceId,
    );
    updateBusy(false);
    print(response);
    switch (response['type']) {
      case 'success':
        return true;
      default:
        return false;
    }
  }
}
