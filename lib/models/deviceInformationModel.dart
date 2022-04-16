class DeviceInformationModel {
  DeviceInformationModel(
      {required this.deviceID,
      required this.deviceModel,
      required this.deviceManufacturer,
      required this.devicePlatform,
      required this.deviceOSVersion,
      required this.isPhysicalDevice,
      required this.deviceJsonData});

  late final String deviceID;
  late final String deviceModel;
  late final String deviceManufacturer;
  late final String devicePlatform;
  late final String deviceOSVersion;
  late final String isPhysicalDevice;
  late final String deviceJsonData;

  DeviceInformationModel.fromJson(Map<String, dynamic> json) {
    deviceID = json['deviceID'];
    deviceModel = json['deviceModel'];
    deviceManufacturer = json['deviceManufacturer'];
    devicePlatform = json['devicePlatform'];
    deviceOSVersion = json['deviceOSVersion'];
    isPhysicalDevice = json['isPhysicalDevice'];
    deviceJsonData = json['deviceJsonData'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['deviceID'] = deviceID;
    _data['deviceModel'] = deviceModel;
    _data['deviceManufacturer'] = deviceManufacturer;
    _data['devicePlatform'] = devicePlatform;
    _data['deviceOSVersion'] = deviceOSVersion;
    _data['isPhysicalDevice'] = isPhysicalDevice;
    _data['deviceJsonData'] = deviceJsonData;
    return _data;
  }
}
