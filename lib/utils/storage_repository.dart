import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  SharedPreferences _preferences;

  Future<void> saveToken(String token) async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString('token', token);
  }

  Future<void> deleteToken() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.remove('token');
  }
}
