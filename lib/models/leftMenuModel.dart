class LeftMenuModel {
  LeftMenuModel({
    required this.MobileEdusprintLeftMenuConfigurationID,
    required this.LeftMenuName,
    required this.LeftMenuDisplayName,
    required this.IsVisible,
    required this.SchoolGroupID,
    required this.SchoolID,
    this.Value,
    required this.IconClassValue,
    required this.ParentMobileEdusprintLeftMenuConfigurationID,
    required this.IsLeftMenu,
    required this.Sequence,
    required this.IsEnableInMobileDasboard,
    this.RedirectUrl,
    required this.IsDisableForDeniedUser,
    this.CustomFields,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
    this.ExtColText1M,
  });

  late final int MobileEdusprintLeftMenuConfigurationID;
  late final String LeftMenuName;
  late final String LeftMenuDisplayName;
  late final bool IsVisible;
  late final int SchoolGroupID;
  late final int SchoolID;
  late final String? Value;
  late final String IconClassValue;
  late final int ParentMobileEdusprintLeftMenuConfigurationID;
  late final bool IsLeftMenu;
  late final int Sequence;
  late final bool IsEnableInMobileDasboard;
  late final String? RedirectUrl;
  late final bool IsDisableForDeniedUser;
  late final String? CustomFields;
  late final String CreatedBy;
  late final String CreatedOn;
  late final String UpdatedBy;
  late final String UpdatedOn;
  late final String? ExtColText1M;

  LeftMenuModel.fromJson(Map<String, dynamic> json) {
    MobileEdusprintLeftMenuConfigurationID =
        json['MobileEdusprintLeftMenuConfigurationID'];
    LeftMenuName = json['LeftMenuName'];
    LeftMenuDisplayName = json['LeftMenuDisplayName'];
    IsVisible = json['IsVisible'];
    SchoolGroupID = json['SchoolGroupID'];
    SchoolID = json['SchoolID'];
    Value = json['Value'] ?? "";
    IconClassValue = json['IconClassValue'] ?? "0xe737";
    ParentMobileEdusprintLeftMenuConfigurationID =
        json['ParentMobileEdusprintLeftMenuConfigurationID'] ?? 0;
    IsLeftMenu = json['IsLeftMenu'];
    Sequence = json['Sequence'] ?? 0;
    IsEnableInMobileDasboard = json['IsEnableInMobileDasboard'];
    RedirectUrl = json['RedirectUrl'];
    IsDisableForDeniedUser = json['IsDisableForDeniedUser'];
    CustomFields = json['CustomFields'];
    CreatedBy = json['CreatedBy'];
    CreatedOn = json['CreatedOn'];
    UpdatedBy = json['UpdatedBy'];
    UpdatedOn = json['UpdatedOn'];
    ExtColText1M = json['ExtColText1M'];
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
    _data['Value'] = Value;
    _data['IconClassValue'] = IconClassValue;
    _data['ParentMobileEdusprintLeftMenuConfigurationID'] =
        ParentMobileEdusprintLeftMenuConfigurationID;
    _data['IsLeftMenu'] = IsLeftMenu;
    _data['Sequence'] = Sequence;
    _data['IsEnableInMobileDasboard'] = IsEnableInMobileDasboard;
    _data['RedirectUrl'] = RedirectUrl;
    _data['IsDisableForDeniedUser'] = IsDisableForDeniedUser;
    _data['CustomFields'] = CustomFields;
    _data['CreatedBy'] = CreatedBy;
    _data['CreatedOn'] = CreatedOn;
    _data['UpdatedBy'] = UpdatedBy;
    _data['UpdatedOn'] = UpdatedOn;
    _data['ExtColText1M'] = ExtColText1M;
    return _data;
  }
}
