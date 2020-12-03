class DeviceModel {
  String type;
  String deviceTag;
  String deviceName;
  String uniqueId;

  DeviceModel({this.type, this.deviceTag, this.deviceName, this.uniqueId});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    deviceTag = json['device_tag'];
    deviceName = json['device_name'];
    uniqueId = json['unique_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['device_tag'] = this.deviceTag;
    data['device_name'] = this.deviceName;
    data['unique_id'] = this.uniqueId;
    return data;
  }
}
