class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.Success,
    this.ResponseMessage,
    this.ResponseData,
  });

  late final bool Success;
  late final String? ResponseMessage;
  late final String? ResponseData;

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    Success = json['Success'];
    ResponseMessage = json['ResponseMessage'];
    ResponseData = json['ResponseData'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Success'] = Success;
    _data['ResponseMessage'] = ResponseMessage;
    _data['ResponseData'] = ResponseData;
    return _data;
  }
}
