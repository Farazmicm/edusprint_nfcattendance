import 'dart:io';

class User {
  User(
      {required this.ExIsActive,
      required this.ExIsExternal,
      required this.ExSchoolGroupID,
      required this.ExIsSchoolGroupAdmin,
      this.ExConfirmPassword,
      this.ExActivatedFrom,
      this.ExVerifyWithin,
      required this.ExUserFullName,
      required this.UserID,
      required this.UserName,
      required this.Password,
      required this.DefaultRoleID,
      required this.CreatedByUserID,
      required this.IsLocked,
      required this.IsChangePasswordRequired,
      required this.IsVerified,
      required this.IsDeleted,
      this.Question1,
      this.Answer1,
      this.Question2,
      this.Answer2,
      this.LastPasswordChangeDate,
      required this.CreatedBy,
      required this.CreatedOn,
      required this.UpdatedBy,
      required this.UpdatedOn,
      this.ExUserName,
      this.ExSchoolGroupCode});

  late final bool ExIsActive;
  late final bool ExIsExternal;
  late final int ExSchoolGroupID;
  late final bool ExIsSchoolGroupAdmin;
  late final String? ExConfirmPassword;
  late final String? ExActivatedFrom;
  late final String? ExVerifyWithin;
  late final String ExUserFullName;
  late final int UserID;
  late final String UserName;
  String? Password;
  late final int DefaultRoleID;
  late final int CreatedByUserID;
  late final bool IsLocked;
  late final bool IsChangePasswordRequired;
  late final bool IsVerified;
  late final bool IsDeleted;
  late final String? Question1;
  late final String? Answer1;
  late final String? Question2;
  late final String? Answer2;
  late final String? LastPasswordChangeDate;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;
  String? ExUserName;
  String? ExSchoolGroupCode;

  User.fromJson(Map<String, dynamic> json) {
    ExIsActive = json['ExIsActive'] ?? false;
    ExIsExternal = json['ExIsExternal'] ?? false;
    ExSchoolGroupID = json['ExSchoolGroupID'] ?? 0;
    ExIsSchoolGroupAdmin = json['ExIsSchoolGroupAdmin'] ?? false;
    ExConfirmPassword = json['ExConfirmPassword'] ?? "";
    ExActivatedFrom = json['ExActivatedFrom'] ?? "";
    ExVerifyWithin = json['ExVerifyWithin'] ?? "";
    ExUserFullName = json['ExUserFullName'] ?? "";
    UserID = json['UserID'] ?? 0;
    UserName = json['UserName'] ?? "";
    Password = json['Password'] ?? "";
    DefaultRoleID = json['DefaultRoleID'] ?? 0;
    CreatedByUserID = json['CreatedByUserID'] ?? 0;
    IsLocked = json['IsLocked'] ?? false;
    IsChangePasswordRequired = json['IsChangePasswordRequired'] ?? false;
    IsVerified = json['IsVerified'] ?? false;
    IsDeleted = json['IsDeleted'] ?? false;
    Question1 = json['Question1'] ?? "";
    Answer1 = json['Answer1'] ?? "";
    Question2 = json['Question2'] ?? "";
    Answer2 = json['Answer2'] ?? "";
    LastPasswordChangeDate = json['LastPasswordChangeDate'] ?? "";
    CreatedBy = json['CreatedBy'] ?? "";
    CreatedOn = json['CreatedOn'] ?? "";
    UpdatedBy = json['UpdatedBy'] ?? "";
    UpdatedOn = json['UpdatedOn'] ?? "";
    ExUserName = json['ExUserName'] ?? json['UserName'];
    ExSchoolGroupCode = json['ExSchoolGroupCode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ExIsActive'] = ExIsActive;
    _data['ExIsExternal'] = ExIsExternal;
    _data['ExSchoolGroupID'] = ExSchoolGroupID;
    _data['ExIsSchoolGroupAdmin'] = ExIsSchoolGroupAdmin;
    _data['ExConfirmPassword'] = ExConfirmPassword;
    _data['ExActivatedFrom'] = ExActivatedFrom;
    _data['ExVerifyWithin'] = ExVerifyWithin;
    _data['ExUserFullName'] = ExUserFullName;
    _data['UserID'] = UserID;
    _data['UserName'] = UserName;
    _data['Password'] = Password;
    _data['DefaultRoleID'] = DefaultRoleID;
    _data['CreatedByUserID'] = CreatedByUserID;
    _data['IsLocked'] = IsLocked;
    _data['IsChangePasswordRequired'] = IsChangePasswordRequired;
    _data['IsVerified'] = IsVerified;
    _data['IsDeleted'] = IsDeleted;
    _data['Question1'] = Question1;
    _data['Answer1'] = Answer1;
    _data['Question2'] = Question2;
    _data['Answer2'] = Answer2;
    _data['LastPasswordChangeDate'] = LastPasswordChangeDate;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    _data['ExUserName'] = ExUserName ?? UserName;
    _data['ExSchoolGroupCode'] = ExSchoolGroupCode;
    return _data;
  }

  User.toNullObject() {
    ExIsActive = false;
    UserName = "";
    ExIsExternal = false;
    ExSchoolGroupID = 0;
    ExIsSchoolGroupAdmin = false;
    ExUserFullName = "";
    UserID = 0;
    Password = "";
    DefaultRoleID = 0;
    CreatedByUserID = 0;
    IsLocked = false;
    IsChangePasswordRequired = false;
    IsVerified = false;
    IsDeleted = false;
    CreatedBy = "";
    CreatedOn = "";
    UpdatedBy = "";
    UpdatedOn = "";
  }
}

class UserProfileModel {
  UserProfileModel({
    this.ExActivatedFrom,
    this.ExUserName,
    this.ExIsActive,
    this.UserID,
    this.LastName,
    this.FirstName,
    this.MiddleName,
    this.UserFullName,
    this.ContactMobileNumber,
    this.EmailID,
    this.AlternateEmailID,
    this.DOB,
    this.GenderID,
    this.BloodGroupID,
    this.CasteID,
    this.SubCasteID,
    this.ReligionID,
    this.MotherTongueID,
    this.FirstLanguageID,
    this.SecondLanguageID,
    this.NationalityID,
    this.NationalityID1,
    this.NativePlace,
    this.BirthPlace,
    this.SocialSecurityNumber,
    this.IsPhysicallyChallenged,
    this.UserImage,
    this.UserImageName,
    this.UserImageTitle,
    this.PassportNo,
    this.PANCardNo,
    this.AdharcardReferenceNumber,
    this.GovernmentUID,
    this.MaritalStatusID,
    this.DigitalSignatureImageName,
    this.DigitalSignatureImageTitle,
    this.ImageTitle1,
    this.Image1,
    this.ImageName1,
    this.ImageTitle2,
    this.Image2,
    this.ImageName2,
    this.ImageTitle3,
    this.Image3,
    this.ImageName3,
    this.ImageTitle4,
    this.Image4,
    this.ImageName4,
    this.ImageTitle5,
    this.Image5,
    this.ImageName5,
    this.ImageTitle6,
    this.Image6,
    this.ImageName6,
    this.CustomFields,
    this.CreatedBy,
    this.CreatedOn,
    this.UpdatedBy,
    this.UpdatedOn,
    this.ExtColInt1,
    this.ExtColInt2,
    this.ExtColInt3,
    this.ExtColInt4,
    this.ExtColInt5,
    this.ExtColInt6,
    this.ExtColInt7,
    this.ExtColInt8,
    this.ExtColInt9,
    this.ExtColInt10,
    this.ExtColDate1,
    this.ExtColDate2,
    this.ExtColDate3,
    this.ExtColDate4,
    this.ExtColDate5,
    this.ExtColDate6,
    this.ExtColDate7,
    this.ExtColDate8,
    this.ExtColDate9,
    this.ExtColDate10,
    this.ExtColText1S,
    this.ExtColText2S,
    this.ExtColText3S,
    this.ExtColText4S,
    this.ExtColText5S,
    this.ExtColText6S,
    this.ExtColText7S,
    this.ExtColText8S,
    this.ExtColText1M,
    this.ExtColText2M,
    this.ExtColText3M,
    this.ExtColText4M,
    this.ExtColText5M,
    this.ExtColText6M,
    this.ExtColText7M,
    this.ExtColText8M,
    this.ExtColText9M,
    this.ExtColText10M,
    this.ExtColText11M,
    this.ExtColText12M,
    this.ExtColText13M,
    this.ExtColText14M,
    this.ExtColText1L,
    this.ExtColText2L,
    this.ExtColText3L,
    this.ExtColText4L,
    this.ExtColText5L,
    this.ExtColText6L,
    this.ExtColText7L,
    this.ExtColText8L,
    this.DeletedOn,
  });
  late final bool? ExActivatedFrom;
  late final String? ExUserName;
  late final bool? ExIsActive;
  late final int? UserID;
  late final String? LastName;
  late final String? FirstName;
  late final String? MiddleName;
  late final String? UserFullName;
  late final String? ContactMobileNumber;
  late final String? EmailID;
  late final String? AlternateEmailID;
  late final String? DOB;
  late final int? GenderID;
  late final int? BloodGroupID;
  late final int? CasteID;
  late final int? SubCasteID;
  late final int? ReligionID;
  late final int? MotherTongueID;
  late final int? FirstLanguageID;
  late final int? SecondLanguageID;
  late final int? NationalityID;
  late final int? NationalityID1;
  late final String? NativePlace;
  late final String? BirthPlace;
  late final String? SocialSecurityNumber;
  late final bool? IsPhysicallyChallenged;
  late final String? UserImage;
  late final String? UserImageName;
  late final String? UserImageTitle;
  late final String? PassportNo;
  late final String? PANCardNo;
  late final String? AdharcardReferenceNumber;
  late final String? GovernmentUID;
  late final int? MaritalStatusID;
  late final String? DigitalSignatureImageName;
  late final String? DigitalSignatureImageTitle;
  late final String? ImageTitle1;
  late final String? Image1;
  late final String? ImageName1;
  late final String? ImageTitle2;
  late final String? Image2;
  late final String? ImageName2;
  late final String? ImageTitle3;
  late final String? Image3;
  late final String? ImageName3;
  late final String? ImageTitle4;
  late final String? Image4;
  late final String? ImageName4;
  late final String? ImageTitle5;
  late final String? Image5;
  late final String? ImageName5;
  late final String? ImageTitle6;
  late final String? Image6;
  late final String? ImageName6;
  late final String? CustomFields;
  late final String? CreatedBy;
  late final String? CreatedOn;
  late final String? UpdatedBy;
  late final String? UpdatedOn;
  late final int? ExtColInt1;
  late final int? ExtColInt2;
  late final int? ExtColInt3;
  late final int? ExtColInt4;
  late final int? ExtColInt5;
  late final int? ExtColInt6;
  late final int? ExtColInt7;
  late final int? ExtColInt8;
  late final int? ExtColInt9;
  late final int? ExtColInt10;
  late final String? ExtColDate1;
  late final String? ExtColDate2;
  late final String? ExtColDate3;
  late final String? ExtColDate4;
  late final String? ExtColDate5;
  late final String? ExtColDate6;
  late final String? ExtColDate7;
  late final String? ExtColDate8;
  late final String? ExtColDate9;
  late final String? ExtColDate10;
  late final String? ExtColText1S;
  late final String? ExtColText2S;
  late final String? ExtColText3S;
  late final String? ExtColText4S;
  late final String? ExtColText5S;
  late final String? ExtColText6S;
  late final String? ExtColText7S;
  late final String? ExtColText8S;
  late final String? ExtColText1M;
  late final String? ExtColText2M;
  late final String? ExtColText3M;
  late final String? ExtColText4M;
  late final String? ExtColText5M;
  late final String? ExtColText6M;
  late final String? ExtColText7M;
  late final String? ExtColText8M;
  late final String? ExtColText9M;
  late final String? ExtColText10M;
  late final String? ExtColText11M;
  late final String? ExtColText12M;
  late final String? ExtColText13M;
  late final String? ExtColText14M;
  late final String? ExtColText1L;
  late final String? ExtColText2L;
  late final String? ExtColText3L;
  late final String? ExtColText4L;
  late final String? ExtColText5L;
  late final String? ExtColText6L;
  late final String? ExtColText7L;
  late final String? ExtColText8L;
  late final String? DeletedOn;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    ExActivatedFrom = json['ExActivatedFrom'] ?? false;
    ExUserName = json['ExUserName'] ?? "";
    ExIsActive = json['ExIsActive'] ?? false;
    UserID = json['UserID'] ?? 0;
    LastName = json['LastName'] ?? "";
    FirstName = json['FirstName'] ?? "";
    MiddleName = json['MiddleName'] ?? "";
    UserFullName = json['UserFullName'] ?? "";
    ContactMobileNumber = json['ContactMobileNumber'] ?? "";
    EmailID = json['EmailID'] ?? "";
    AlternateEmailID = json['AlternateEmailID'] ?? "";
    DOB = json['DOB'] ?? "";
    GenderID = json['GenderID'] ?? 0;
    BloodGroupID = json['BloodGroupID'] ?? 0;
    CasteID = json['CasteID'] ?? 0;
    SubCasteID = json['SubCasteID'] ?? 0;
    ReligionID = json['ReligionID'] ?? 0;
    MotherTongueID = json['MotherTongueID'] ?? 0;
    FirstLanguageID = json['FirstLanguageID'] ?? 0;
    SecondLanguageID = json['SecondLanguageID'] ?? 0;
    NationalityID = json['NationalityID'] ?? 0;
    NationalityID1 = json['NationalityID1'] ?? 0;
    NativePlace = json['NativePlace'] ?? "";
    BirthPlace = json['BirthPlace'] ?? "";
    SocialSecurityNumber = json['SocialSecurityNumber'] ?? "";
    IsPhysicallyChallenged = json['IsPhysicallyChallenged'] ?? false;
    UserImage = json['UserImage'] ?? "";
    UserImageName = json['UserImageName'] ?? "";
    UserImageTitle = json['UserImageTitle'] ?? "";
    PassportNo = json['PassportNo'] ?? "";
    PANCardNo = json['PANCardNo'] ?? "";
    AdharcardReferenceNumber = json['AdharcardReferenceNumber'] ?? "";
    GovernmentUID = json['GovernmentUID'] ?? "";
    MaritalStatusID = json['MaritalStatusID'] ?? 0;

    DigitalSignatureImageName = json['GovernmentUID'] ?? "";
    DigitalSignatureImageTitle = json['GovernmentUID'] ?? "";
    ImageTitle1 = json['GovernmentUID'] ?? "";
    Image1 = json['GovernmentUID'] ?? "";
    ImageName1 = json['GovernmentUID'] ?? "";
    ImageTitle2 = json['GovernmentUID'] ?? "";
    Image2 = json['GovernmentUID'] ?? "";
    ImageName2 = json['GovernmentUID'] ?? "";
    ImageTitle3 = json['GovernmentUID'] ?? "";
    Image3 = json['GovernmentUID'] ?? "";
    ImageName3 = json['GovernmentUID'] ?? "";
    ImageTitle4 = json['GovernmentUID'] ?? "";
    Image4 = json['GovernmentUID'] ?? "";
    ImageName4 = json['GovernmentUID'] ?? "";
    ImageTitle5 = json['GovernmentUID'] ?? "";
    Image5 = json['GovernmentUID'] ?? "";
    ImageName5 = json['GovernmentUID'] ?? "";
    ImageTitle6 = json['GovernmentUID'] ?? "";
    Image6 = json['GovernmentUID'] ?? "";
    ImageName6 = json['GovernmentUID'] ?? "";
    CustomFields = json['GovernmentUID'] ?? "";
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
    ExtColInt1 = json['ExtColInt1'] ?? 0;
    ExtColInt2 = json['ExtColInt2'] ?? 0;
    ExtColInt3 = json['ExtColInt3'] ?? 0;
    ExtColInt4 = json['ExtColInt4'] ?? 0;
    ExtColInt5 = json['ExtColInt5'] ?? 0;
    ExtColInt6 = json['ExtColInt6'] ?? 0;
    ExtColInt7 = json['ExtColInt7'] ?? 0;
    ExtColInt8 = json['ExtColInt8'] ?? 0;
    ExtColInt9 = json['ExtColInt9'] ?? 0;
    ExtColInt10 = json['ExtColInt10'] ?? 0;
    ExtColDate1 = json['ExtColDate1'] ?? "";
    ExtColDate2 = json['ExtColDate2'] ?? "";
    ExtColDate3 = json['ExtColDate3'] ?? "";
    ExtColDate4 = json['ExtColDate4'] ?? "";
    ExtColDate5 = json['ExtColDate5'] ?? "";
    ExtColDate6 = json['ExtColDate6'] ?? "";
    ExtColDate7 = json['ExtColDate7'] ?? "";
    ExtColDate8 = json['ExtColDate8'] ?? "";
    ExtColDate9 = json['ExtColDate9'] ?? "";
    ExtColDate10 = json['ExtColDate10'] ?? "";
    ExtColText1S = json['ExtColText1S'] ?? "";
    ExtColText2S = json['ExtColText2S'] ?? "";
    ExtColText3S = json['ExtColText3S'] ?? "";
    ExtColText4S = json['ExtColText4S'] ?? "";
    ExtColText5S = json['ExtColText5S'] ?? "";
    ExtColText6S = json['ExtColText6S'] ?? "";
    ExtColText7S = json['ExtColText7S'] ?? "";
    ExtColText8S = json['ExtColText8S'] ?? "";
    ExtColText1M = json['ExtColText1M'] ?? "";
    ExtColText2M = json['ExtColText2M'] ?? "";
    ExtColText3M = json['ExtColText3M'] ?? "";
    ExtColText4M = json['ExtColText4M'] ?? "";
    ExtColText5M = json['ExtColText5M'] ?? "";
    ExtColText6M = json['ExtColText6M'] ?? "";
    ExtColText7M = json['ExtColText7M'] ?? "";
    ExtColText8M = json['ExtColText8M'] ?? "";
    ExtColText9M = json['ExtColText9M'] ?? "";
    ExtColText10M = json['ExtColText10M'] ?? "";
    ExtColText11M = json['ExtColText11M'] ?? "";
    ExtColText12M = json['ExtColText12M'] ?? "";
    ExtColText13M = json['ExtColText13M'] ?? "";
    ExtColText14M = json['ExtColText14M'] ?? "";
    ExtColText1L = json['ExtColText1L'] ?? "";
    ExtColText2L = json['ExtColText2L'] ?? "";
    ExtColText3L = json['ExtColText3L'] ?? "";
    ExtColText4L = json['ExtColText4L'] ?? "";
    ExtColText5L = json['ExtColText5L'] ?? "";
    ExtColText6L = json['ExtColText6L'] ?? "";
    ExtColText7L = json['ExtColText7L'] ?? "";
    ExtColText8L = json['ExtColText8L'] ?? "";
    DeletedOn = json['DeletedOn'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ExActivatedFrom'] = ExActivatedFrom;
    _data['ExUserName'] = ExUserName;
    _data['ExIsActive'] = ExIsActive;
    _data['UserID'] = UserID;
    _data['LastName'] = LastName;
    _data['FirstName'] = FirstName;
    _data['MiddleName'] = MiddleName;
    _data['UserFullName'] = UserFullName;
    _data['ContactMobileNumber'] = ContactMobileNumber;
    _data['EmailID'] = EmailID;
    _data['AlternateEmailID'] = AlternateEmailID;
    _data['DOB'] = DOB;
    _data['GenderID'] = GenderID;
    _data['BloodGroupID'] = BloodGroupID;
    _data['CasteID'] = CasteID;
    _data['SubCasteID'] = SubCasteID;
    _data['ReligionID'] = ReligionID;
    _data['MotherTongueID'] = MotherTongueID;
    _data['FirstLanguageID'] = FirstLanguageID;
    _data['SecondLanguageID'] = SecondLanguageID;
    _data['NationalityID'] = NationalityID;
    _data['NationalityID1'] = NationalityID1;
    _data['NativePlace'] = NativePlace;
    _data['BirthPlace'] = BirthPlace;
    _data['SocialSecurityNumber'] = SocialSecurityNumber;
    _data['IsPhysicallyChallenged'] = IsPhysicallyChallenged;
    _data['UserImage'] = UserImage;
    _data['UserImageName'] = UserImageName;
    _data['UserImageTitle'] = UserImageTitle;
    _data['PassportNo'] = PassportNo;
    _data['PANCardNo'] = PANCardNo;
    _data['AdharcardReferenceNumber'] = AdharcardReferenceNumber;
    _data['GovernmentUID'] = GovernmentUID;
    _data['MaritalStatusID'] = MaritalStatusID;
    _data['DigitalSignatureImageName'] = DigitalSignatureImageName;
    _data['DigitalSignatureImageTitle'] = DigitalSignatureImageTitle;
    _data['ImageTitle1'] = ImageTitle1;
    _data['Image1'] = Image1;
    _data['ImageName1'] = ImageName1;
    _data['ImageTitle2'] = ImageTitle2;
    _data['Image2'] = Image2;
    _data['ImageName2'] = ImageName2;
    _data['ImageTitle3'] = ImageTitle3;
    _data['Image3'] = Image3;
    _data['ImageName3'] = ImageName3;
    _data['ImageTitle4'] = ImageTitle4;
    _data['Image4'] = Image4;
    _data['ImageName4'] = ImageName4;
    _data['ImageTitle5'] = ImageTitle5;
    _data['Image5'] = Image5;
    _data['ImageName5'] = ImageName5;
    _data['ImageTitle6'] = ImageTitle6;
    _data['Image6'] = Image6;
    _data['ImageName6'] = ImageName6;
    _data['CustomFields'] = CustomFields;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    _data['ExtColInt1'] = ExtColInt1;
    _data['ExtColInt2'] = ExtColInt2;
    _data['ExtColInt3'] = ExtColInt3;
    _data['ExtColInt4'] = ExtColInt4;
    _data['ExtColInt5'] = ExtColInt5;
    _data['ExtColInt6'] = ExtColInt6;
    _data['ExtColInt7'] = ExtColInt7;
    _data['ExtColInt8'] = ExtColInt8;
    _data['ExtColInt9'] = ExtColInt9;
    _data['ExtColInt10'] = ExtColInt10;
    _data['ExtColDate1'] = ExtColDate1;
    _data['ExtColDate2'] = ExtColDate2;
    _data['ExtColDate3'] = ExtColDate3;
    _data['ExtColDate4'] = ExtColDate4;
    _data['ExtColDate5'] = ExtColDate5;
    _data['ExtColDate6'] = ExtColDate6;
    _data['ExtColDate7'] = ExtColDate7;
    _data['ExtColDate8'] = ExtColDate8;
    _data['ExtColDate9'] = ExtColDate9;
    _data['ExtColDate10'] = ExtColDate10;
    _data['ExtColText1S'] = ExtColText1S;
    _data['ExtColText2S'] = ExtColText2S;
    _data['ExtColText3S'] = ExtColText3S;
    _data['ExtColText4S'] = ExtColText4S;
    _data['ExtColText5S'] = ExtColText5S;
    _data['ExtColText6S'] = ExtColText6S;
    _data['ExtColText7S'] = ExtColText7S;
    _data['ExtColText8S'] = ExtColText8S;
    _data['ExtColText1M'] = ExtColText1M;
    _data['ExtColText2M'] = ExtColText2M;
    _data['ExtColText3M'] = ExtColText3M;
    _data['ExtColText4M'] = ExtColText4M;
    _data['ExtColText5M'] = ExtColText5M;
    _data['ExtColText6M'] = ExtColText6M;
    _data['ExtColText7M'] = ExtColText7M;
    _data['ExtColText8M'] = ExtColText8M;
    _data['ExtColText9M'] = ExtColText9M;
    _data['ExtColText10M'] = ExtColText10M;
    _data['ExtColText11M'] = ExtColText11M;
    _data['ExtColText12M'] = ExtColText12M;
    _data['ExtColText13M'] = ExtColText13M;
    _data['ExtColText14M'] = ExtColText14M;
    _data['ExtColText1L'] = ExtColText1L;
    _data['ExtColText2L'] = ExtColText2L;
    _data['ExtColText3L'] = ExtColText3L;
    _data['ExtColText4L'] = ExtColText4L;
    _data['ExtColText5L'] = ExtColText5L;
    _data['ExtColText6L'] = ExtColText6L;
    _data['ExtColText7L'] = ExtColText7L;
    _data['ExtColText8L'] = ExtColText8L;
    _data['DeletedOn'] = DeletedOn;
    return _data;
  }
}

class MobileEdusprintLeftMenuConfiguration {
  MobileEdusprintLeftMenuConfiguration({
    required this.MobileEdusprintLeftMenuConfigurationID,
    required this.LeftMenuName,
    required this.LeftMenuDisplayName,
    required this.IsVisible,
    required this.SchoolGroupID,
    required this.SchoolID,
    required this.IsLeftMenu,
    required this.IconClass,
    required this.IsEnableInMobileDasboard,
    required this.IsDisableForDeniedUser,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  late final int MobileEdusprintLeftMenuConfigurationID;
  late final String LeftMenuName;
  late final String LeftMenuDisplayName;
  late final bool IsVisible;
  late final int SchoolGroupID;
  late final int SchoolID;
  late final bool IsLeftMenu;
  late final String IconClass;
  late final bool IsEnableInMobileDasboard;
  late final bool IsDisableForDeniedUser;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;

  MobileEdusprintLeftMenuConfiguration.fromJson(Map<String, dynamic> json) {
    MobileEdusprintLeftMenuConfigurationID =
        json['MobileEdusprintLeftMenuConfigurationID'];
    LeftMenuName = json['LeftMenuName'];
    LeftMenuDisplayName = json['LeftMenuDisplayName'];
    IsVisible = json['IsVisible'];
    SchoolGroupID = json['SchoolGroupID'];
    SchoolID = json['SchoolID'];
    IsLeftMenu = json['IsLeftMenu'];
    IconClass = json['IconClass'];
    IsEnableInMobileDasboard = json['IsEnableInMobileDasboard'];
    IsDisableForDeniedUser = json['IsDisableForDeniedUser'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['MobileEdusprintLeftMenuConfigurationID'] =
        MobileEdusprintLeftMenuConfigurationID;
    _data['LeftMenuName'] = LeftMenuName;
    _data['LeftMenuDisplayName'] = LeftMenuDisplayName;
    _data['IsVisible'] = IsVisible;
    _data['SchoolGroupID'] = SchoolGroupID;
    _data['SchoolID'] = SchoolID;
    _data['IsLeftMenu'] = IsLeftMenu;
    _data['IconClass'] = IconClass;
    _data['IsEnableInMobileDasboard'] = IsEnableInMobileDasboard;
    _data['IsDisableForDeniedUser'] = IsDisableForDeniedUser;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    return _data;
  }
}

class UserVerificationResult<T> {
  bool isVerified;
  String statusCode;
  String? responseMessge;
  T? object;
  Map<String, dynamic>? responseData;

  UserVerificationResult(
      {required this.isVerified,
      required this.statusCode,
      this.object,
      this.responseMessge = "",
      this.responseData});
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
