import 'dart:developer';

import 'package:embesys_ctrl/models/weather_model.dart';
import 'package:embesys_ctrl/providers/base_provider.dart';
import 'package:embesys_ctrl/utils/network_repository.dart';

class WeatherProvider extends BaseProvider {
  WeatherProvider() {
    loadWeather();
  }

  WeatherModel _model;

  WeatherModel get model => _model;

  void _updateModel(WeatherModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Future loadWeather() async {
    updateBusy(true);
    Map response = await networkRepository.loadWeather(city: 'Paranaque');
    updateBusy(false);
    switch (response['type']) {
      case 'success':
        _updateModel(WeatherModel.fromJson(response['response']));
        print(_model);
        break;
      default:
        log('there was a problem. ${response['type']}');
    }
  }
}
