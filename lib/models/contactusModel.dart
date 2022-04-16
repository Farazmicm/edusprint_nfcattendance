class School {
  School({
    required this.SchoolID,
    required this.SchoolName,
    required this.ShortName,
    required this.AddressID,
    required this.SchoolGroupID,
    required this.SchoolImage,
    required this.SchoolImageName,
    required this.SchoolLogoImage,
    required this.SchoolLogoImageName,
    required this.SchoolBannerImage,
    required this.SchoolBannerImageName,
    required this.Email,
    required this.Sequence,
    required this.LocationMasterID,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  late final int SchoolID;
  late final String SchoolName;
  late final String ShortName;
  late final int AddressID;
  late final int SchoolGroupID;
  late final String SchoolImage;
  late final String SchoolImageName;
  late final String SchoolLogoImage;
  late final String SchoolLogoImageName;
  late final String SchoolBannerImage;
  late final String SchoolBannerImageName;
  late final String Email;
  late final int Sequence;
  late final int LocationMasterID;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;

  School.fromJson(Map<String, dynamic> json) {
    SchoolID = json['SchoolID'];
    SchoolName = json['SchoolName'];
    ShortName = json['ShortName'] ?? "";
    AddressID = json['AddressID'] ?? 0;
    SchoolGroupID = json['SchoolGroupID'];
    SchoolImage = json['SchoolImage'] ?? "";
    SchoolImageName = json['SchoolImageName'] ?? "";
    SchoolLogoImage = json['SchoolLogoImage'] ?? "";
    SchoolLogoImageName = json['SchoolLogoImageName'] ?? "";
    SchoolBannerImage = json['SchoolBannerImage'] ?? "";
    SchoolBannerImageName = json['SchoolBannerImageName'] ?? "";
    Email = json['Email'] ?? "";
    Sequence = json['Sequence'] ?? 0;
    LocationMasterID = json['LocationMasterID'] ?? 0;
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['SchoolID'] = SchoolID;
    _data['SchoolName'] = SchoolName;
    _data['ShortName'] = ShortName;
    _data['AddressID'] = AddressID;
    _data['SchoolGroupID'] = SchoolGroupID;
    _data['SchoolImage'] = SchoolImage;
    _data['SchoolImageName'] = SchoolImageName;
    _data['SchoolLogoImage'] = SchoolLogoImage;
    _data['SchoolLogoImageName'] = SchoolLogoImageName;
    _data['SchoolBannerImage'] = SchoolBannerImage;
    _data['SchoolBannerImageName'] = SchoolBannerImageName;
    _data['Email'] = Email;
    _data['Sequence'] = Sequence;
    _data['LocationMasterID'] = LocationMasterID;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    return _data;
  }
}

class Address {
  Address({
    required this.ExIsStudentAddress,
    required this.AddressID,
    required this.AddressHeaderID,
    required this.Address1,
    required this.Address2,
    required this.Station,
    required this.City,
    required this.PostalCode,
    required this.Landline1,
    required this.MobileNo1,
    required this.MobileNo2,
    required this.Fax,
    required this.Website,
    required this.SchoolGroupID,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  late final bool ExIsStudentAddress;
  late final int AddressID;
  late final int AddressHeaderID;
  late final String Address1;
  late final String Address2;
  late final String Station;
  late final String City;
  late final String PostalCode;
  late final String Landline1;
  late final String MobileNo1;
  late final String MobileNo2;
  late final String Fax;
  late final String Website;
  late final int SchoolGroupID;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;

  Address.fromJson(Map<String, dynamic> json) {
    ExIsStudentAddress = json['ExIsStudentAddress'];
    AddressID = json['AddressID'];
    AddressHeaderID = json['AddressHeaderID'];
    Address1 = json['Address1'];
    Address2 = json['Address2'] ?? "NA";
    Station = json['Station'] ?? "NA";
    City = json['City'] ?? "NA";
    PostalCode = json['PostalCode'] ?? "NA";
    Landline1 = json['Landline1'] ?? "NA";
    MobileNo1 = json['MobileNo1'] ?? "NA";
    MobileNo2 = json['MobileNo2'] ?? "NA";
    Fax = json['Fax'] ?? "NA";
    Website = json['Website'] ?? "NA";
    SchoolGroupID = json['SchoolGroupID'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ExIsStudentAddress'] = ExIsStudentAddress;
    _data['AddressID'] = AddressID;
    _data['AddressHeaderID'] = AddressHeaderID;
    _data['Address1'] = Address1;
    _data['Address2'] = Address2;
    _data['Station'] = Station;
    _data['City'] = City;
    _data['PostalCode'] = PostalCode;
    _data['Landline1'] = Landline1;
    _data['MobileNo1'] = MobileNo1;
    _data['MobileNo2'] = MobileNo2;
    _data['Fax'] = Fax;
    _data['Website'] = Website;
    _data['SchoolGroupID'] = SchoolGroupID;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    return _data;
  }
}

class LocationMaster {
  LocationMaster({
    required this.LocationMasterID,
    required this.LocationName,
    required this.LocationAddress,
  });

  late final int LocationMasterID;
  late final String LocationName;
  late final String LocationAddress;

  LocationMaster.fromJson(Map<String, dynamic> json) {
    LocationMasterID = json['LocationMasterID'];
    LocationName = json['LocationName'];
    LocationAddress = json['LocationAddress'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['LocationMasterID'] = LocationMasterID;
    _data['LocationName'] = LocationName;
    _data['LocationAddress'] = LocationAddress;
    return _data;
  }
}

class ContactusModel {
  late final String schoolID;
  late final String name;
  late final String address;
  late final String phone;
  late final String email;
  late final String contactSubject;
  late final String contactMessage;
  late final bool contactByPhone;
  late final bool contactByEmail;
}
