class DhtModel {
  final double humidity;
  final double temperature;
  final DateTime date;

  DhtModel({this.humidity, this.temperature, this.date});

  factory DhtModel.fromJson(Map json) => DhtModel(
        temperature: json['temperature'],
        humidity: json['humidity'],
        date: json['date'],
      );
}
