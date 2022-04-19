class AttendanceUserDetails {
  AttendanceUserDetails({
    this.UserID,
    this.UserName,
    this.UserFullName,
    this.ContactNo,
    this.UID,
    this.ClassName,
    this.DivisionName,
    this.UserType,
    this.RFIDNumbers,
  });
  late final int? UserID;
  late final String? UserName;
  late final String? UserFullName;
  late final String? ContactNo;
  late final String? UID;
  late final String? ClassName;
  late final String? DivisionName;
  late final String? UserType;
  late final String? RFIDNumbers;

  AttendanceUserDetails.fromJson(Map<String, dynamic> json){
    UserID = json['UserID'] ?? 0;
    UserName = json['UserName'] ?? "";
    UserFullName = json['UserFullName'] ?? "";
    ContactNo = json['ContactNo'] ?? "";
    UID = json['UID'] ?? "";
    ClassName = json['ClassName'] ?? "";
    DivisionName = json['DivisionName'] ?? "";
    UserType = json['UserType'] ?? "";
    RFIDNumbers = json['RFIDNumbers'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['UserFullName'] = UserFullName;
    _data['ContactNo'] = ContactNo;
    _data['UID'] = UID;
    _data['ClassName'] = ClassName;
    _data['DivisionName'] = DivisionName;
    _data['UserType'] = UserType;
    _data['RFIDNumbers'] = RFIDNumbers;
    return _data;
  }
}