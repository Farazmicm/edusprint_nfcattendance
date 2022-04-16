class NewTokenModel {
  NewTokenModel({
    required this.Success,
    required this.ResponseData,
  });

  late bool Success;
  late String ResponseData;

  NewTokenModel.fromJson(Map<String, dynamic> json) {
    Success = json['Success'];
    ResponseData = json['ResponseData'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Success'] = Success;
    _data['ResponseData'] = ResponseData;
    return _data;
  }
}
