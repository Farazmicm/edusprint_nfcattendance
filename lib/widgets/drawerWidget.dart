import 'dart:convert' as convert;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/models/leftMenuModel.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/utilities/common.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../utilities/constants.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  var lstLefMenuLinkWidget = <Widget>[];
  late Widget headerWidget;
  late Widget userAccountListWidget;

  @override
  void initState() {
    handleStartupLogic();
    //filLeftMenu();
    super.initState();
  }

  handleStartupLogic() async {
    headerWidget = Container();
    userAccountListWidget = Container();
    await getUsers().then((value) async => await filLeftMenu());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        children: [
          headerWidget,
          Column(
            children: lstLefMenuLinkWidget,
          ),
        ],
      ),
    );
  }

  Future<void> filLeftMenu() async {
    var theme = Theme.of(context);
    try {
      var arrayLink = convert.jsonDecode(await Utility.readLocalStorage(
          localStorageKeyEnum.LstMobileAppLeftMenu.toString()));

      //Convert array to list
      var lstAllLink =
          List.from(arrayLink).map((e) => LeftMenuModel.fromJson(e)).toList();

      //#region for som other link
      var lstSomeOtherlink = lstAllLink
          .where((element) =>
              element.IsVisible == true &&
              element.IsLeftMenu == false &&
              element.Value != "")
          .toList();
      if (lstSomeOtherlink.length > 0) {
        lstSomeOtherlink.forEachIndexed((index, element) {
          switch (element.Value) {
            case "onlinefees":
              isShow_OnlinePayment = true;
              break;
            case "feesoutstanding":
              isShow_FeesOutStanding = true;
              break;
          }
        });
      }
      //#endregion for som other link

      var lstLeftMenu = lstAllLink
          .where((element) => element.IsVisible == true)
          .toList()
        ..sorted((a, b) => a.Sequence.compareTo(b.Sequence));

      setState(() {
        lstLefMenuLinkWidget.add(userAccountListWidget);
        lstLefMenuLinkWidget.add(Divider(
          color: Colors.lightBlue.shade500,
          height: 0,
          thickness: 0,
        ));

        lstLefMenuLinkWidget.add(_createDrawerItem(
            icon: Icon(
              Icons.dashboard_rounded,
              color: theme.colorScheme.primary,
            ),
            text: "Dashboard",
            onTap: () => Navigator.popAndPushNamed(context, "dashboard")));

        //#region Link With Sequence
        lstLeftMenu
            .where((element) =>
                element.IsLeftMenu == true &&
                element.Sequence > 0 &&
                element.ParentMobileEdusprintLeftMenuConfigurationID == 0)
            .forEachIndexed((index, element) async {
          //Fetch Child Menu
          var lstSubLeftMenu = lstLeftMenu
              .where((objLeftMenu) =>
                  objLeftMenu.ParentMobileEdusprintLeftMenuConfigurationID ==
                  element.MobileEdusprintLeftMenuConfigurationID)
              .toList();

          if (lstSubLeftMenu.length > 0) {
            //#region Root and Child
            var lstSubMenuWidget = <MenuItemModel>[];
            lstSubLeftMenu.forEachIndexed((index, oChildMenu) {
              lstSubMenuWidget.add(
                MenuItemModel(
                  icon: CircleAvatar(
                    child: Icon(
                      IconData(int.parse(element.IconClassValue),
                          fontFamily: 'MaterialIcons'),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  text: oChildMenu.LeftMenuDisplayName,
                  onTap: () => getWebUrlOpenWebView(
                      oChildMenu.LeftMenuName,
                      oChildMenu.LeftMenuDisplayName,
                      oChildMenu.RedirectUrl ?? "",
                      oChildMenu.Value ?? ""),
                ),
              );
            });

            lstLefMenuLinkWidget.add(_createExpandableDrawerItem(
                icon: Icon(
                  IconData(int.parse(element.IconClassValue),
                      fontFamily: 'MaterialIcons'),
                  color: theme.colorScheme.primary,
                ),
                text: element.LeftMenuDisplayName,
                menuItemModel: lstSubMenuWidget));

            //#endregion Root and Child
          } else {
            //#region Root Menu
            lstLefMenuLinkWidget.add(_createDrawerItem(
              icon: Icon(
                IconData(int.parse(element.IconClassValue),
                    fontFamily: 'MaterialIcons'),
                color: theme.colorScheme.primary,
              ),
              // icon: Icon(IconData(0xea5a, fontFamily: 'MaterialIcons')),
              text: element.LeftMenuDisplayName,
              onTap: () => getWebUrlOpenWebView(
                  element.LeftMenuName,
                  element.LeftMenuDisplayName,
                  element.RedirectUrl ?? "",
                  element.Value ?? ""),
            ));
            //#endregion Root Menu
          }
        });
        //#endregion

        //#region Link Without Sequence
        lstLeftMenu
            .where((element) =>
                element.IsLeftMenu == true &&
                element.Sequence < 1 &&
                element.ParentMobileEdusprintLeftMenuConfigurationID == 0)
            .forEachIndexed((index, element) async {
          //Fetch Child Menu
          var lstSubLeftMenu = lstLeftMenu
              .where((objLeftMenu) =>
                  objLeftMenu.ParentMobileEdusprintLeftMenuConfigurationID ==
                  element.MobileEdusprintLeftMenuConfigurationID)
              .toList();

          if (lstSubLeftMenu.length > 0) {
            //#region Root and Child
            var lstSubMenuWidget = <MenuItemModel>[];
            lstSubLeftMenu.forEachIndexed((index, oChildMenu) {
              lstSubMenuWidget.add(
                MenuItemModel(
                  icon: Icon(
                    IconData(int.parse(element.IconClassValue),
                        fontFamily: 'MaterialIcons'),
                    color: theme.colorScheme.primary,
                  ),
                  text: oChildMenu.LeftMenuDisplayName,
                  onTap: () => getWebUrlOpenWebView(
                      oChildMenu.LeftMenuName,
                      oChildMenu.LeftMenuDisplayName,
                      oChildMenu.RedirectUrl ?? "",
                      oChildMenu.Value ?? ""),
                ),
              );
            });

            lstLefMenuLinkWidget.add(_createExpandableDrawerItem(
                icon: Icon(
                  IconData(int.parse(element.IconClassValue),
                      fontFamily: 'MaterialIcons'),
                  color: theme.colorScheme.primary,
                ),
                text: element.LeftMenuDisplayName,
                menuItemModel: lstSubMenuWidget));
            //#endregion Root and Child
          } else {
            //#region Root Menu
            lstLefMenuLinkWidget.add(_createDrawerItem(
              icon: Icon(
                IconData(int.parse(element.IconClassValue),
                    fontFamily: 'MaterialIcons'),
                color: theme.colorScheme.primary,
              ),
              // icon: Icon(IconData(0xea5a, fontFamily: 'MaterialIcons')),
              text: element.LeftMenuDisplayName,
              onTap: () => getWebUrlOpenWebView(
                  element.LeftMenuName,
                  element.LeftMenuDisplayName,
                  element.RedirectUrl ?? "",
                  element.Value ?? ""),
            ));
            //#endregion Root Menu
          }
        });
        //#endregion
        lstLefMenuLinkWidget.add(Divider(
          color: theme.colorScheme.primary,
          height: 0,
          thickness: 0,
        ));
        lstLefMenuLinkWidget.add(_createDrawerItem(
            icon: Icon(
              Icons.logout,
              color: theme.colorScheme.primary,
            ),
            text: "Logout",
            onTap: () async {
              await logOutConfirmation(context);
            }));
      });
    } catch (e) {
      print(e);
      await syncError("filLeftMenu", e);
    }
  }

  void getWebUrlOpenWebView(String leftMenuName, String LeftMenuDisplayName,
      String redirectUrl, String menuValue) async {
    try {
      ProgressDialog dialog = ProgressDialog(context,
          blur: 2,
          dialogTransitionType: DialogTransitionType.Shrink,
          message: CustomText(content: "Please wait..."),
          dialogStyle: DialogStyle(
            elevation: 5,
          ),
          dismissable: false);
      dialog.show();

      if (menuValue != "" && menuValue.contains('.html')) {
        dialog.dismiss();
        Navigator.popAndPushNamed(context, leftMenuName.toLowerCase(),
            arguments: LeftMenuDisplayName);
      } else if (redirectUrl != "" && redirectUrl.contains("http")) {
        dialog.dismiss();
        Navigator.popAndPushNamed(
          context,
          "webviewcall",
          arguments: redirectUrl + '###' + LeftMenuDisplayName,
        );
      } else {
        await ecampusWebFromURL(menuValue).then((value) {
          dialog.dismiss();
          print("Hello");
          return Navigator.popAndPushNamed(
            context,
            "webviewcall",
            arguments: value + '###' + LeftMenuDisplayName,
          );
        });
      }
    } catch (e) {
      print(e);
      await syncError("getWebUrlOpenWebView", e);
    }
  }

  Future<void> getUsers() async {
    final loginUsers = await UserDetailsRepository.getUserDetails();
    var oCurrentUser = loginUsers.firstWhere((element) {
      return element.UserID == int.parse(UserID);
    });
    bool IsOtherUsersAvailable = loginUsers.length > 1 ? true : false;
    List<VWStudentFullDetailNullable> oOtherUsers = loginUsers
        .where((element) => element.UserID != oCurrentUser.UserID)
        .toList();
    var oUserAccountList = <MenuItemModel>[];

    //#region CurrentUser
    var oUsername = oCurrentUser.UserFullName != null
        ? oCurrentUser.UserFullName
        : "Student Name";
    var oSecondline =
        (oCurrentUser.ClassName != null ? oCurrentUser.ClassName : "") +
            (oCurrentUser.DivisionName != null
                ? " - " + oCurrentUser.DivisionName
                : "") +
            (oCurrentUser.YearDescription != null
                ? (" (" + oCurrentUser.YearDescription + ")")
                : "");

    var oDefaultImage =
        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80";
    var oUserImage =
        oCurrentUser.UserImage.isEmpty || oCurrentUser.UserImage == "-"
            ? ""
            : (imageFileHostedPath + oCurrentUser.UserImage);
    var oUserInitial = oCurrentUser.UserFullName != null
        ? (oCurrentUser.FirstName.substring(0, 1) +
            " " +
            oCurrentUser.LastName.substring(0, 1))
        : "";

    oUserAccountList.add(MenuItemModel(
      icon: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal.shade600, width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(4.0),
        child: oUserImage.isNotEmpty && oUserImage != ""
            ? (CircleAvatar(
                backgroundImage: NetworkImage(oUserImage),
                backgroundColor: Colors.teal.shade100,
              ))
            : CircleAvatar(
                backgroundColor: Colors.white30,
                child: CustomTextSingleLine(
                    content: oUserInitial,
                    style: TextStyle(
                        color: Colors.teal.shade600,
                        fontWeight: FontWeight.w300,
                        fontSize: 12))),
      ),
      text: oUsername + "\n" + oSecondline,
      onTap: () => Navigator.popAndPushNamed(context, "changeyear",
          arguments: "Change Year"),
      isDisplayAsCurrent: true,
    ));

    //#endregion CurrentUser

    setState(() {
      var theme = Theme.of(context);
      var otherUsersWidgets = <Widget>[];

      oOtherUsers.forEachIndexed((index, element) async {
        var oDUsername = element.UserFullName != null
            ? element.UserFullName
            : "Student Name";
        var oDSecondline = (element.ClassName != null
                ? element.ClassName
                : "") +
            (element.DivisionName != null ? " - " + element.DivisionName : "") +
            (element.YearDescription != null
                ? (" (" + element.YearDescription + ")")
                : "");
        var oDUserImage = element.UserImage.isEmpty || element.UserImage == "-"
            ? ""
            : (imageFileHostedPath + element.UserImage);
        var oDUserInitial = element.UserFullName != null
            ? (element.FirstName.substring(0, 1) +
                " " +
                element.LastName.substring(0, 1))
            : "";
        //var isFileAvailable = await verifyFile(oDUserImage);
        //#region OtherUserWidgets
        otherUsersWidgets.add(GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary, width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(4.0),
              child: (oDUserImage.isNotEmpty && oDUserImage != ""
                  ? (CircleAvatar(
                      backgroundImage: NetworkImage(oDUserImage),
                      backgroundColor: theme.colorScheme.background))
                  : CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      child: CustomTextSingleLine(
                          content: oDUserInitial,
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w300,
                              fontSize: 12)))),
            ),
            onTap: () async {
              await switchUser(element.UserID).then((value) {
                print("Name: " + oDUsername + "\nSecondLine: " + oDSecondline);
              });
            }));
        //#endregion OtherUserWidgets

        //#region Other UserDropDown

        oUserAccountList.add(MenuItemModel(
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.primary, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(4.0),
            child: oDUserImage.isNotEmpty && oDUserImage != ""
                ? CircleAvatar(
                    backgroundImage: NetworkImage(oDUserImage),
                    backgroundColor: theme.colorScheme.secondary,
                  )
                : CircleAvatar(
                    backgroundColor: theme.colorScheme.secondary,
                    child: CustomTextSingleLine(
                        content: oDUserInitial,
                        style: GoogleFonts.lato(
                            color: theme.colorScheme.background,
                            fontSize: 12))),
          ),
          text: oDUsername + "\n" + oDSecondline,
          onTap: () async {
            await switchUser(element.UserID).then((value) {
              print("Name: " + oDUsername + "\nSecondLine: " + oDSecondline);
            });
          },
        ));

        //#endregion DropDown
      });

      userAccountListWidget = _createExpandableDrawerItem(
        icon: Icon(
          IconData(0xf01f4, fontFamily: 'MaterialIcons'),
          color: theme.colorScheme.primary,
        ),
        text: "Accounts",
        menuItemModel: oUserAccountList,
        isDividerNeed: true,
      );

      headerWidget = DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: theme.colorScheme.secondary),
        child: Stack(children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: CustomTextSingleLine(
                content: oUsername,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            accountEmail: CustomText(
                content: oSecondline + "\n" + oCurrentUser.SchoolName,
                style: GoogleFonts.lato(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            currentAccountPicture: GestureDetector(
                child: (Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: oUserImage.isNotEmpty && oUserImage != ""
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(oUserImage),
                          backgroundColor: theme.colorScheme.secondary,
                          child: oUserImage.isNotEmpty && oUserImage != ""
                              ? Container()
                              : CustomTextSingleLine(
                                  content: oUserInitial,
                                  style: GoogleFonts.lato(
                                      color: theme.colorScheme.background,
                                      fontSize: 20)))
                      : CircleAvatar(
                          backgroundColor: theme.colorScheme.secondary,
                          child: CustomTextSingleLine(
                              content: oUserInitial,
                              style: GoogleFonts.lato(
                                  color: theme.colorScheme.background,
                                  fontSize: 20)),
                        ),
                )),
                onTap: () => Navigator.popAndPushNamed(context, "changeyear",
                    arguments: "Change Year")),
            //.. This line of code provides the usage of multiple accounts
            arrowColor: Colors.grey,
            otherAccountsPictures:
                IsOtherUsersAvailable ? otherUsersWidgets : <Widget>[],
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              gradient: const RadialGradient(
                tileMode: TileMode.mirror,
                colors: [Colors.white, Colors.teal],
                radius: 3,
              ),
            ),
            margin: EdgeInsets.zero,
          )
        ]),
      );
    });
  }

  //Single Menu Item
  Widget _createDrawerItem(
      {required Widget icon,
      required String text,
      GestureTapCallback? onTap,
      bool isChildTile = false}) {
    var them = Theme.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: them.colorScheme.primaryVariant,
        child: icon,
      ),
      focusColor: them.colorScheme.background,
      title: CustomText(
        content: text,
        style: isChildTile ? TextStyle(fontSize: 12) : null,
      ),
      onTap: onTap,
    );
  }

  //Multilevel Menu Item
  Widget _createExpandableDrawerItem(
      {required Widget icon,
      required String text,
      List<MenuItemModel>? menuItemModel,
      Color? itemBackgroundColor,
      bool? isDividerNeed = false}) {
    var theme = Theme.of(context);
    final children = <Widget>[];
    menuItemModel!.forEach((element) {
      children.add(_createDrawerItem(
          icon: Stack(
            children: [
              element.icon,
              element.isDisplayAsCurrent == true
                  ? Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          text: element.text,
          onTap: element.onTap));
      if (isDividerNeed!)
        children.add(Divider(
          color: theme.colorScheme.primary,
          height: 0,
          thickness: 0,
        ));
    });
    return ExpansionTile(
      backgroundColor: itemBackgroundColor,
      collapsedBackgroundColor: itemBackgroundColor,
      title: CustomText(
        content: text,
      ),
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryVariant,
        child: icon,
      ),
      children: children,
      childrenPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    );
  }
}

class MenuItemModel {
  final Widget icon;
  final String text;
  GestureTapCallback? onTap;
  bool? isDisplayAsCurrent;

  MenuItemModel(
      {required this.icon,
      required this.text,
      this.onTap,
      this.isDisplayAsCurrent = false});
}
