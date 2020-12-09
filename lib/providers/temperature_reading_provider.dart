import 'package:embesys_ctrl/models/temperature_reading_model.dart';
import 'package:embesys_ctrl/providers/base_provider.dart';

class TemperatureReadingProvider extends BaseProvider {
  List<TemperatureReadingModel> _readings = [];
  bool _error = false;
  bool _initialLoadDone = false;

  List<TemperatureReadingModel> get readings => _readings;
  bool get error => _error;

  updateError(bool didError) {
    _error = didError;
    notifyListeners();
  }

  _updateInitialLoad(bool didLoad) {
    _initialLoadDone = didLoad;
  }

  updateReadings(List<TemperatureReadingModel> lst) {
    _readings.addAll(lst);
    notifyListeners();
  }

  Future<List<TemperatureReadingModel>> loadDhtReadings() async {
    if (_error) updateError(false);
    if (!_initialLoadDone) {
      updateBusy(true);
    }
    _readings.clear();
    final res = await networkRepository.loadDhtReadings();
    _updateInitialLoad(true);
    updateBusy(false);
    switch (res['type']) {
      case 'success':
        final list = (res['message'] as List)
            .map((e) => TemperatureReadingModel.fromJson(e))
            .toList();
        updateReadings(list);
        return _readings;
      default:
        updateError(true);
        return [];
    }
  }
}
