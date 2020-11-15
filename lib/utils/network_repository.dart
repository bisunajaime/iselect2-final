import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:embesys_ctrl/constants.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkRepository {
  http.Client _client = new http.Client();
  IOWebSocketChannel _channel;
  String _baseUrl = "http://192.168.254.117";
  String _weatherStackBaseUrl = "http://api.weatherstack.com";
  String _socketUrl = "ws://192.168.254.117:81";

  NetworkRepository() {
    _channel = IOWebSocketChannel.connect(_socketUrl);
  }

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

  Future<Map> socketLed(Map data) async {
    try {
      // _channel.stream.listen((event) {
      //   print(event);
      // });
      _channel.sink.add(jsonEncode(data));
      // _channel.sink.close();
      return {
        'type': 'success',
        'response': 'Updated',
      };
    } on WebSocketChannelException catch (e) {
      return {
        'type': 'error',
        'error': e.toString(),
      };
    } catch (e) {
      log(e.toString());
      return {
        'type': 'error',
        'error': e.toString(),
      };
    }
  }
}
