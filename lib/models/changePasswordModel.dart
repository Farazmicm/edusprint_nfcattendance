class ChangePasswordModel {
  ChangePasswordModel(
    this.UserID,
    this.UpdatedOn,
    this.ActionName,
    this.OldPassword,
    this.NewPassword,
  );

  final int UserID;
  final String? UpdatedOn;
  final String? ActionName;
  late String? OldPassword;
  late String? NewPassword;
}

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    required this.ResponseMessage,
    required this.IsSuccess,
  });

  late final String ResponseMessage;
  late final bool IsSuccess;

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    ResponseMessage = json['ResponseMessage'];
    IsSuccess = json['IsSuccess'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ResponseMessage'] = ResponseMessage;
    _data['IsSuccess'] = IsSuccess;
    return _data;
  }
}
