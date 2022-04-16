import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/models/VWStudentFullDetailNullable.dart';
import 'package:nfcdemo/ui/login/schoolGroupWiseLogin.dart';
import 'package:nfcdemo/utilities/common.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/customtile.dart';
import 'package:nfcdemo/widgets/global_context.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../database_mng/repository/userdetails_repository.dart';

class ManageUserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.white,
          builder: (context) => UserDetailsBody(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          )),
      child: Icon(Icons.group),
    );
  }
}

class UserDetailsBody extends StatelessWidget {
  var theme = Theme.of(GlobalContext.navigatorKey.currentContext!);
  String appBarTitle;

  UserDetailsBody({this.appBarTitle = "Manage Students"});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      initialData: CustomMessage(
        msg: "No Data",
      ),
      future: UserDetailsRepository.getUserDetails(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasData) {
          List<dynamic> userList = snapshot.data;
          if (userList.isNotEmpty) {
            var oCurrentUser =
                UserID == "" || UserID.isEmpty ? 0 : int.parse(UserID);
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: CustomText(content: appBarTitle),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue[50],
                        child: InkWell(
                          splashColor: Colors.blue[50],
                          onTap: () {
                            Navigator.pop(context);
                            showLoginProcess(context);
                          },
                          child: SizedBox(
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.person_add_alt_1_outlined,
                                color: Colors.blueGrey,
                              )),
                        ),
                        shadowColor: Colors.black,
                        type: MaterialType.card,
                      ),
                    ),
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(bottom: 2, left: 2),
                child: ListView.builder(
                  itemCount: userList.length,
                  padding: const EdgeInsets.all(2.0),
                  itemBuilder: (context, index) {
                    VWStudentFullDetailNullable _vw = userList[index];
                    //#region Declaration
                    var oDUsername = _vw.UserFullName != null
                        ? _vw.UserFullName
                        : "Student Name";
                    var oDSecondline =
                        (_vw.ClassName != null ? _vw.ClassName : "") +
                            (_vw.DivisionName != null
                                ? " - " + _vw.DivisionName
                                : "") +
                            (_vw.YearDescription != null
                                ? (" (" + _vw.YearDescription + ")")
                                : "");
                    var oDUserImage =
                        _vw.UserImage.isEmpty || _vw.UserImage == "-"
                            ? ""
                            : (_vw.UserImage);
                    var oDUserInitial = _vw.UserFullName != null
                        ? (_vw.FirstName.substring(0, 1) +
                            " " +
                            _vw.LastName.substring(0, 1))
                        : "";
                    //#endregion Declaration
                    var isCurrentUser = (oCurrentUser == _vw.UserID);
                    return CustomTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.colorScheme.primary, width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: getUserIcon(oDUserImage, oDUserInitial)),
                      ),
                      mini: true,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: theme.colorScheme.primary, width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(5, 5))),
                      title: CustomText(content: oDUsername),
                      subtitle: CustomText(content: oDSecondline),
                      trailing: Row(
                        verticalDirection: VerticalDirection.up,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomChipIcone(
                              bgColor: theme.colorScheme.primaryVariant,
                              onClick: () async =>
                                  await logOutConfirmation(context),
                              icone: Icon(
                                Icons.logout,
                                color: theme.colorScheme.secondary,
                                size: 14,
                              ),
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => AwesomeDialog(
                          context: context,
                          dialogType: DialogType.QUESTION,
                          animType: AnimType.SCALE,
                          headerAnimationLoop: true,
                          dismissOnTouchOutside: false,
                          title: isCurrentUser ? 'Swicth Year' : 'Sign In',
                          desc: isCurrentUser
                              ? 'Are you sure, you want to switch year ?'
                              : 'Are you sure, you want to sign in as ${_vw.UserFullName}?',
                          btnCancelText: "Cancel",
                          btnCancelOnPress: () {},
                          btnCancelIcon: Icons.close,
                          btnOkText: isCurrentUser ? 'Swicth Year' : 'Sign in',
                          btnOkOnPress: () async {
                            if (isCurrentUser) {
                              Navigator.popAndPushNamed(context, "changeyear",
                                  arguments: "Change Year");
                            } else {
                              Navigator.pop(context);
                              await switchUser(_vw.UserID);
                            }
                          },
                          btnOkIcon: Icons.logout,
                          btnOkColor: Colors.blue)
                        ..show(),
                      margin: EdgeInsets.all(5.0),
                    );
                  },
                ),
              ),
            );
          }
          return CustomMessage(msg: "No Users Available");
        }
        return CustomMessage(msg: "No Users Available");
      },
    );
  }

  Widget getUserIcon(String userImage, String userInitial) {
    return userImage.isNotEmpty
        ? InkWell(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                clipBehavior: Clip.antiAlias,
                child: ImageWithNetwork(
                  url: userImage,
                  boxFit: BoxFit.fill,
                  width: 45,
                  height: 45,
                )))
        : CircleAvatar(
            child: CustomTextSingleLine(
              content: userInitial,
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            backgroundColor: theme.colorScheme.primaryVariant,
            foregroundColor: theme.colorScheme.secondary,
          );
  }

  showLoginProcess(BuildContext context) {
    showBottomSheetPage(
        context: context,
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: SchoolGroupWiseLogin(isAddStudents: true),
        ),
        isDrawerRequired: true,
        appbar: AppBar(
            title: CustomText(content: "New Student Login"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipOval(
                  child: Material(
                    color: Colors.blue[50],
                    child: InkWell(
                      splashColor: Colors.blue[50],
                      onTap: () {
                        Navigator.pop(
                            GlobalContext.navigatorKey.currentContext!);
                      },
                      child: SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            Icons.close,
                            color: Colors.blueGrey,
                          )),
                    ),
                    shadowColor: Colors.black,
                    type: MaterialType.card,
                  ),
                ),
              )
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            )));
  }
}
