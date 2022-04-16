class Students {
  Students({
    required this.UserID,
    required this.LastName,
    required this.FirstName,
    required this.UserFullName,
    required this.ContactMobileNumber,
    required this.DOB,
    required this.GenderID,
    required this.IsPhysicallyChallenged,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  late final int UserID;
  late final String LastName;
  late final String FirstName;
  late final String UserFullName;
  late final String ContactMobileNumber;
  late final String DOB;
  late final int GenderID;
  late final bool IsPhysicallyChallenged;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;

  Students.fromJson(Map<String, dynamic> json) {
    UserID = json['UserID'];
    LastName = json['LastName'];
    FirstName = json['FirstName'];
    UserFullName = json['UserFullName'];
    ContactMobileNumber = json['ContactMobileNumber'];
    DOB = json['DOB'];
    GenderID = json['GenderID'];
    IsPhysicallyChallenged = json['IsPhysicallyChallenged'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['UserID'] = UserID;
    _data['LastName'] = LastName;
    _data['FirstName'] = FirstName;
    _data['UserFullName'] = UserFullName;
    _data['ContactMobileNumber'] = ContactMobileNumber;
    _data['DOB'] = DOB;
    _data['GenderID'] = GenderID;
    _data['IsPhysicallyChallenged'] = IsPhysicallyChallenged;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    return _data;
  }
}

class StudentYears {
  StudentYears({
    required this.YearMasterID,
    required this.CommonYearID,
    required this.StartDate,
    required this.EndDate,
    required this.Description,
    required this.YearTypeID,
    required this.Sequence,
    required this.SchoolID,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  late final int YearMasterID;
  late final int CommonYearID;
  late final String StartDate;
  late final String EndDate;
  late final String Description;
  late final int YearTypeID;
  late final int Sequence;
  late final int SchoolID;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;

  StudentYears.fromJson(Map<String, dynamic> json) {
    YearMasterID = json['YearMasterID'];
    CommonYearID = json['CommonYearID'];
    StartDate = json['StartDate'];
    EndDate = json['EndDate'];
    Description = json['Description'];
    YearTypeID = json['YearTypeID'];
    Sequence = json['Sequence'];
    SchoolID = json['SchoolID'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['YearMasterID'] = YearMasterID;
    _data['CommonYearID'] = CommonYearID;
    _data['StartDate'] = StartDate;
    _data['EndDate'] = EndDate;
    _data['Description'] = Description;
    _data['YearTypeID'] = YearTypeID;
    _data['Sequence'] = Sequence;
    _data['SchoolID'] = SchoolID;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    return _data;
  }
}
