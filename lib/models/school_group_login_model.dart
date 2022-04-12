class SchoolGroupWiseLoginModel {
  SchoolGroupWiseLoginModel({
    required this.ClientID,
    this.ClientName,
    this.ClientShortCode,
    this.ClientWEBURL,
    this.ClientGroupImagePath,
    this.CreatedBy,
    required this.CreatedOn,
    this.UpdatedBy,
    required this.UpdatedOn,
    this.DeletedOn,
    this.ExtColBool,
    this.ExtColInt,
    this.ExtColDateTime,
    this.ExtColTextS,
    this.ExtColTextM,
    this.ExtColTextL,
    this.GeoLocationWEBURL,
    required this.IsMICMGeolocationServer,
    this.ClientMobileAppCode,
    required this.IsGoogleLogin,
    required this.MBMClientKeyValuePair,
    required this.MBMBBPSHostToHostDetail,
  });
  late final int ClientID;
  late final String? ClientName;
  late final String? ClientShortCode;
  late final String? ClientWEBURL;
  late final String? ClientGroupImagePath;
  late final String? CreatedBy;
  late final String? CreatedOn;
  late final String? UpdatedBy;
  late final String UpdatedOn;
  late final String? DeletedOn;
  late final bool? ExtColBool;
  late final int? ExtColInt;
  late final String? ExtColDateTime;
  late final String? ExtColTextS;
  late final String? ExtColTextM;
  late final String? ExtColTextL;
  late final String? GeoLocationWEBURL;
  late final bool IsMICMGeolocationServer;
  late final String? ClientMobileAppCode;
  late final bool IsGoogleLogin;
  late final List<dynamic> MBMClientKeyValuePair;
  late final List<dynamic> MBMBBPSHostToHostDetail;

  SchoolGroupWiseLoginModel.fromJson(Map<String, dynamic> json){
    MBMClientKeyValuePair = List.castFrom<dynamic, dynamic>(json['MB_M_ClientKeyValuePair']);
    MBMBBPSHostToHostDetail = List.castFrom<dynamic, dynamic>(json['MB_M_BBPSHostToHostDetail']);
    ClientID = json['ClientID'];
    ClientName = json['ClientName'];
    ClientShortCode = json['ClientShortCode'];
    ClientWEBURL = json['ClientWEBURL'];
    ClientGroupImagePath = json['ClientGroupImagePath'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
    DeletedOn = json['DeletedOn'];;
    ExtColBool = json['ExtColBool'];;
    ExtColInt = json['ExtColInt'];;
    ExtColDateTime = json['ExtColDateTime'];;
    ExtColTextS = json['ExtColTextS'];;
    ExtColTextM = json['ExtColTextS'];
    ExtColTextL = json['ExtColTextL'];;
    GeoLocationWEBURL = json['GeoLocationWEBURL'];
    IsMICMGeolocationServer = json['IsMICMGeolocationServer'];
    ClientMobileAppCode = json['ClientMobileAppCode'];
    IsGoogleLogin = json['IsGoogleLogin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['MB_M_ClientKeyValuePair'] = MBMClientKeyValuePair;
    _data['MB_M_BBPSHostToHostDetail'] = MBMBBPSHostToHostDetail;
    _data['ClientID'] = ClientID;
    _data['ClientName'] = ClientName;
    _data['ClientShortCode'] = ClientShortCode;
    _data['ClientWEBURL'] = ClientWEBURL;
    _data['ClientGroupImagePath'] = ClientGroupImagePath;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    _data['DeletedOn'] = DeletedOn;
    _data['ExtColBool'] = ExtColBool;
    _data['ExtColInt'] = ExtColInt;
    _data['ExtColDateTime'] = ExtColDateTime;
    _data['ExtColTextS'] = ExtColTextS;
    _data['ExtColTextM'] = ExtColTextM;
    _data['ExtColTextL'] = ExtColTextL;
    _data['GeoLocationWEBURL'] = GeoLocationWEBURL;
    _data['IsMICMGeolocationServer'] = IsMICMGeolocationServer;
    _data['ClientMobileAppCode'] = ClientMobileAppCode;
    _data['IsGoogleLogin'] = IsGoogleLogin;
    return _data;
  }
}