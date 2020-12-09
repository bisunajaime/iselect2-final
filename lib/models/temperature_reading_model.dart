class TemperatureReadingModel {
  int id;
  num temperature;
  num humidity;
  String createdAt;
  String updatedAt;

  TemperatureReadingModel(
      {this.id,
      this.temperature,
      this.humidity,
      this.createdAt,
      this.updatedAt});

  TemperatureReadingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
