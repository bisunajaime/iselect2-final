class WifiDetailsProvider {
  Stream<String> _wifiName;

  Stream<String> get wifiName => _wifiName;

  void _updateWifiName(String name) {}

  Future<void> getWifiDetails() async {}
}
