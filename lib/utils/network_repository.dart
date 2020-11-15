import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  http.Client _client = new http.Client();
  String _baseUrl = "http://192.168.254.117";
  String _weatherStackBaseUrl = "http://api.weatherstack.com";

  Future<Map> loadWeather({String city = "Manila"}) async {
    try {
      http.Response response = await _client
          .get(
              '$_weatherStackBaseUrl/current?access_key=$weatherStackApiKey&query=$city')
          .timeout(Duration(seconds: 10));
      final body = jsonDecode(response.body);
      return {
        'type': 'success',
        'response': body,
      };
    } on TimeoutException catch (e) {
      return {
        'type': 'timeout',
        'response': e.message,
      };
    } catch (e) {
      return {
        'type': 'error',
        'response': e.toString(),
      };
    }
  }

  Future<Map> toggleLed(String route, {String state = "ON"}) async {
    try {
      log(route);
      http.Response response = await _client
          .get('$_baseUrl$route$state')
          .timeout(Duration(seconds: 10));
      // final body = jsonDecode(response.body);
      return {
        'type': 'success',
        'response': 'Success',
      };
    } on TimeoutException catch (e) {
      return {
        'type': 'timeout',
        'response': e.message,
      };
    } catch (e) {
      return {
        'type': 'error',
        'response': e.toString(),
      };
    }
  }
}
