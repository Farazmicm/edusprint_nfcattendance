class VWStudentFullDetailNullable {
  VWStudentFullDetailNullable({
    required this.StudentID,
    required this.SchoolName,
    required this.YearDescription,
    required this.UserFullName,
    required this.FirstName,
    required this.MiddleName,
    required this.ContactMobileNumber,
    required this.EmailID,
    required this.DOB,
    required this.NativePlace,
    required this.FamilyIncome,
    required this.IsPhysicallyChallenged,
    required this.UserImage,
    required this.UserImageName,
    required this.PANCardNo,
    required this.AdharcardReferenceNumber,
    required this.StudentActive,
    required this.DOA,
    required this.Eligibility,
    required this.IsAdmissionDueToTransfer,
    required this.IsAdmissionCancelled,
    required this.NewStudent,
    required this.SchoolShortName,
    required this.ClassName,
    required this.DivisionName,
    required this.GenderName,
    required this.BloodGroupName,
    required this.CasteName,
    required this.SubCasteName,
    required this.ReligionName,
    required this.DivisionPrintName,
    required this.MotherTongueName,
    required this.NationalityName,
    required this.StudentYearID,
    required this.UID,
    required this.UserID,
    required this.YearMasterID,
    required this.LastName,
    required this.SchoolID,
    required this.GenderID,
    required this.ShortName,
    required this.ClassMasterID,
    required this.PrintName,
    required this.DivisionMasterID,
    required this.NationalityID,
    required this.MotherTongueID,
    required this.ReligionID,
    required this.SubCasteID,
    required this.CasteID,
    required this.BloodGroupID,
    required this.SectionMasterID,
    required this.SectionName,
    required this.StudentGRNumberID,
    required this.GRNumber,
    required this.UserName,
    required this.IsVerified,
    required this.UserUpdatedON,
    required this.StudentYearUpdatedON,
    required this.StudentUpdatedON,
    required this.UserProfileUpdatedON,
    required this.StudentGRUpdatedON,
    required this.SectionSequence,
    required this.ClassSequence,
    required this.StudentYearActive,
    required this.DivisionSequence,
    required this.IsStudentAcademic,
    required this.SaralNumber,
    required this.BirthPlace,
    required this.BirthPlaceCountry,
    required this.BirthPlaceDistrict,
    required this.BirthPlaceState,
    required this.BirthPlaceTaluka,
  });

  late final int StudentID;
  late final String SchoolName;
  late final String YearDescription;
  late final String UserFullName;
  late final String FirstName;
  late final String MiddleName;
  late final String ContactMobileNumber;
  late final String EmailID;
  late final String DOB;
  late final String BirthPlace;
  late final String NativePlace;
  late final double FamilyIncome;
  late final bool IsPhysicallyChallenged;
  late final String UserImage;
  late final String UserImageName;
  late final String PANCardNo;
  late final String AdharcardReferenceNumber;
  late final bool StudentActive;
  late final String DOA;
  late final bool Eligibility;
  late final bool IsAdmissionDueToTransfer;
  late final bool IsAdmissionCancelled;
  late final bool NewStudent;
  late final String SchoolShortName;
  late final String ClassName;
  late final String DivisionName;
  late final String GenderName;
  late final String BloodGroupName;
  late final String CasteName;
  late final String SubCasteName;
  late final String ReligionName;
  late final String DivisionPrintName;
  late final String MotherTongueName;
  late final String NationalityName;
  late final int StudentYearID;
  late final String UID;
  late final int UserID;
  late final int YearMasterID;
  late final String LastName;
  late final int SchoolID;
  late final int GenderID;
  late final String ShortName;
  late final int ClassMasterID;
  late final String PrintName;
  late final int DivisionMasterID;
  late final int NationalityID;
  late final int MotherTongueID;
  late final int ReligionID;
  late final int SubCasteID;
  late final int CasteID;
  late final int BloodGroupID;
  late final int SectionMasterID;
  late final String SectionName;
  late final int StudentGRNumberID;
  late final String GRNumber;
  late final String UserName;
  late final bool IsVerified;
  late final String UserUpdatedON;
  late final String StudentYearUpdatedON;
  late final String StudentUpdatedON;
  late final String UserProfileUpdatedON;
  late final String StudentGRUpdatedON;
  late final int SectionSequence;
  late final int ClassSequence;
  late final bool StudentYearActive;
  late final int DivisionSequence;
  late final bool IsStudentAcademic;
  late final String SaralNumber;
  late final String BirthPlaceTaluka;
  late final String BirthPlaceDistrict;
  late final String BirthPlaceState;
  late final String BirthPlaceCountry;

  VWStudentFullDetailNullable.fromJson(Map<String, dynamic> json) {
    StudentID = json['StudentID'];
    SchoolName = json['SchoolName'];
    YearDescription = json['YearDescription'] ?? "-";
    UserFullName = json['UserFullName'] ?? "-";
    FirstName = json['FirstName'] ?? "-";
    MiddleName = json['MiddleName'] ?? "-";
    ContactMobileNumber = json['ContactMobileNumber'] ?? "-";
    EmailID = json['EmailID'] ?? "-";
    DOB = json['DOB'] ?? "-";
    BirthPlace = json['BirthPlace'] ?? "-";
    NativePlace = json['NativePlace'] ?? "-";
    FamilyIncome = json['FamilyIncome'] ?? 0;
    IsPhysicallyChallenged = json['IsPhysicallyChallenged'];
    UserImage = json['UserImage'] ?? "-";
    UserImageName = json['UserImageName'] ?? "-";
    PANCardNo = json['PANCardNo'] ?? "-";
    AdharcardReferenceNumber = json['AdharcardReferenceNumber'] ?? "-";
    StudentActive = json['StudentActive'] ?? false;
    DOA = json['DOA'] ?? "-";
    Eligibility = json['Eligibility'] ?? false;
    IsAdmissionDueToTransfer = json['IsAdmissionDueToTransfer'] ?? false;
    IsAdmissionCancelled = json['IsAdmissionCancelled'] ?? false;
    NewStudent = json['NewStudent'] ?? false;
    SchoolShortName = json['SchoolShortName'] ?? "-";
    ClassName = json['ClassName'] ?? "-";
    DivisionName = json['DivisionName'] ?? "-";
    GenderName = json['GenderName'] ?? "-";
    BloodGroupName = json['BloodGroupName'] ?? "-";
    CasteName = json['CasteName'] ?? "-";
    SubCasteName = json['SubCasteName'] ?? "-";
    ReligionName = json['ReligionName'] ?? "-";
    DivisionPrintName = json['DivisionPrintName'] ?? "-";
    MotherTongueName = json['MotherTongueName'] ?? "-";
    NationalityName = json['NationalityName'] ?? "-";
    StudentYearID = json['StudentYearID'] ?? 0;
    UID = json['UID'] ?? "-";
    UserID = json['UserID'] ?? 0;
    YearMasterID = json['YearMasterID'] ?? 0;
    LastName = json['LastName'] ?? "-";
    SchoolID = json['SchoolID'] ?? 0;
    GenderID = json['GenderID'] ?? 0;
    ShortName = json['ShortName'] ?? "-";
    ClassMasterID = json['ClassMasterID'] ?? 0;
    PrintName = json['PrintName'] ?? "-";
    DivisionMasterID = json['DivisionMasterID'] ?? 0;
    NationalityID = json['NationalityID'] ?? 0;
    MotherTongueID = json['MotherTongueID'] ?? 0;
    ReligionID = json['ReligionID'] ?? 0;
    SubCasteID = json['SubCasteID'] ?? 0;
    CasteID = json['CasteID'] ?? 0;
    BloodGroupID = json['BloodGroupID'] ?? 0;
    SectionMasterID = json['SectionMasterID'] ?? 0;
    SectionName = json['SectionName'] ?? "-";
    StudentGRNumberID = json['StudentGRNumberID'] ?? 0;
    GRNumber = json['GRNumber'] ?? "-";
    UserName = json['UserName'] ?? "-";
    UserUpdatedON = json['UserUpdatedON'] ?? "-";
    StudentYearUpdatedON = json['StudentYearUpdatedON'] ?? "-";
    StudentUpdatedON = json['StudentUpdatedON'] ?? "-";
    UserProfileUpdatedON = json['UserProfileUpdatedON'] ?? "-";
    StudentGRUpdatedON = json['StudentGRUpdatedON'] ?? "-";
    SaralNumber = json['SaralNumber'] ?? "-";
    BirthPlaceTaluka = json["BirthPlaceTaluka"] ?? "-";
    BirthPlaceDistrict = json["BirthPlaceDistrict"] ?? "-";
    BirthPlaceState = json["BirthPlaceState"] ?? "-";
    BirthPlaceCountry = json["BirthPlaceCountry"] ?? "-";
    IsVerified = json["IsVerified"] ?? false;
    SectionSequence = json["SectionSequence"] ?? 0;
    ClassSequence = json["ClassSequence"] ?? 0;
    StudentYearActive = json["StudentYearActive"];
    DivisionSequence = json["DivisionSequence"] ?? 0;
    IsStudentAcademic = json["IsStudentAcademic"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['StudentID'] = StudentID;
    _data['SchoolName'] = SchoolName;
    _data['YearDescription'] = YearDescription;
    _data['UserFullName'] = UserFullName;
    _data['FirstName'] = FirstName;
    _data['MiddleName'] = MiddleName;
    _data['ContactMobileNumber'] = ContactMobileNumber;
    _data['EmailID'] = EmailID;
    _data['DOB'] = DOB;
    _data['BirthPlace'] = BirthPlace;
    _data['NativePlace'] = NativePlace;
    _data['FamilyIncome'] = FamilyIncome;
    _data['IsPhysicallyChallenged'] = IsPhysicallyChallenged;
    _data['UserImage'] = UserImage;
    _data['UserImageName'] = UserImageName;
    _data['PANCardNo'] = PANCardNo;
    _data['AdharcardReferenceNumber'] = AdharcardReferenceNumber;
    _data['StudentActive'] = StudentActive;
    _data['DOA'] = DOA;
    _data['Eligibility'] = Eligibility;
    _data['IsAdmissionDueToTransfer'] = IsAdmissionDueToTransfer;
    _data['IsAdmissionCancelled'] = IsAdmissionCancelled;
    _data['NewStudent'] = NewStudent;
    _data['SchoolShortName'] = SchoolShortName;
    _data['ClassName'] = ClassName;
    _data['DivisionName'] = DivisionName;
    _data['GenderName'] = GenderName;
    _data['BloodGroupName'] = BloodGroupName;
    _data['CasteName'] = CasteName;
    _data['SubCasteName'] = SubCasteName;
    _data['ReligionName'] = ReligionName;
    _data['DivisionPrintName'] = DivisionPrintName;
    _data['MotherTongueName'] = MotherTongueName;
    _data['NationalityName'] = NationalityName;
    _data['StudentYearID'] = StudentYearID;
    _data['UID'] = UID;
    _data['UserID'] = UserID;
    _data['YearMasterID'] = YearMasterID;
    _data['LastName'] = LastName;
    _data['SchoolID'] = SchoolID;
    _data['GenderID'] = GenderID;
    _data['ShortName'] = ShortName;
    _data['ClassMasterID'] = ClassMasterID;
    _data['PrintName'] = PrintName;
    _data['DivisionMasterID'] = DivisionMasterID;
    _data['NationalityID'] = NationalityID;
    _data['MotherTongueID'] = MotherTongueID;
    _data['ReligionID'] = ReligionID;
    _data['SubCasteID'] = SubCasteID;
    _data['CasteID'] = CasteID;
    _data['BloodGroupID'] = BloodGroupID;
    _data['SectionMasterID'] = SectionMasterID;
    _data['SectionName'] = SectionName;
    _data['StudentGRNumberID'] = StudentGRNumberID;
    _data['GRNumber'] = GRNumber;
    _data['UserName'] = UserName;
    _data['IsVerified'] = IsVerified;
    _data['UserUpdatedON'] = UserUpdatedON;
    _data['StudentYearUpdatedON'] = StudentYearUpdatedON;
    _data['StudentUpdatedON'] = StudentUpdatedON;
    _data['UserProfileUpdatedON'] = UserProfileUpdatedON;
    _data['StudentGRUpdatedON'] = StudentGRUpdatedON;
    _data['SectionSequence'] = SectionSequence;
    _data['ClassSequence'] = ClassSequence;
    _data['StudentYearActive'] = StudentYearActive;
    _data['DivisionSequence'] = DivisionSequence;
    _data['IsStudentAcademic'] = IsStudentAcademic;
    _data['SaralNumber'] = SaralNumber;
    _data['BirthPlaceTaluka'] = BirthPlaceTaluka;
    _data['BirthPlaceDistrict'] = BirthPlaceDistrict;
    _data['BirthPlaceState'] = BirthPlaceState;
    _data['BirthPlaceCountry'] = BirthPlaceCountry;
    return _data;
  }

  VWStudentFullDetailNullable.toNullObject() {
    StudentID = 0;
    SchoolName = "";
    YearDescription = "";
    UserFullName = "";
    FirstName = "";
    MiddleName = "";
    ContactMobileNumber = "";
    EmailID = "";
    DOB = "";
    NativePlace = "";
    FamilyIncome = 0;
    IsPhysicallyChallenged = false;
    UserImage = "";
    UserImageName = "";
    PANCardNo = "";
    AdharcardReferenceNumber = "";
    StudentActive = false;
    DOA = "";
    Eligibility = false;
    IsAdmissionDueToTransfer = false;
    IsAdmissionCancelled = false;
    NewStudent = false;
    SchoolShortName = "";
    ClassName = "";
    DivisionName = "";
    GenderName = "";
    BloodGroupName = "";
    CasteName = "";
    SubCasteName = "";
    ReligionName = "";
    DivisionPrintName = "";
    MotherTongueName = "";
    NationalityName = "";
    StudentYearID = 0;
    UID = "";
    UserID = 0;
    YearMasterID = 0;
    LastName = "";
    SchoolID = 0;
    GenderID = 0;
    ShortName = "";
    ClassMasterID = 0;
    PrintName = "";
    DivisionMasterID = 0;
    NationalityID = 0;
    MotherTongueID = 0;
    ReligionID = 0;
    SubCasteID = 0;
    CasteID = 0;
    BloodGroupID = 0;
    SectionMasterID = 0;
    SectionName = "";
    StudentGRNumberID = 0;
    GRNumber = "";
    UserName = "";
    IsVerified = false;
    UserUpdatedON = "";
    StudentYearUpdatedON = "";
    StudentUpdatedON = "";
    UserProfileUpdatedON = "";
    StudentGRUpdatedON = "";
    SectionSequence = 0;
    ClassSequence = 0;
    StudentYearActive = false;
    DivisionSequence = 0;
    IsStudentAcademic = false;
    SaralNumber = "";
    BirthPlace = "";
    BirthPlaceCountry = "";
    BirthPlaceDistrict = "";
    BirthPlaceState = "";
    BirthPlaceTaluka = "";
  }
}
