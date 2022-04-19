import 'package:flutter/material.dart';
import 'package:nfcdemo/widgets/widgets.dart';
import 'package:nfcdemo/models/attendanceUserDetailsModel.dart';
import 'package:nfcdemo/database_mng/repository/attendance_userprofile_repository.dart';
import 'package:nfcdemo/widgets/global_context.dart';
import 'package:nfcdemo/widgets/customtile.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceUserDetailsPage extends StatelessWidget {
  const AttendanceUserDetailsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder<dynamic>(
        initialData: CustomMessage(
          msg: "No Data",
        ),
        future: AttendanceUserProfileRepository.getAttendanceUserProfiles(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasData) {
            List<dynamic> userList = snapshot.data;
            if (userList.isNotEmpty) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 2),
                  child: ListView.builder(

                    itemCount: userList.length,
                    padding: const EdgeInsets.all(2.0),
                    itemBuilder: (context, index) {
                      AttendanceUserDetails _vw = userList[index];
                      //#region Declaration
                      var oDUsername = _vw.UserFullName != null
                          ? _vw.UserFullName
                          : "User Name";
                      var oDUserInitial = _vw.UserFullName != null
                          ? (_vw.UserFullName!.substring(0, 2))
                          : "";
                      //#endregion Declaration
                      return CustomTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.colorScheme.primary, width: 2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: getUserIcon("", oDUserInitial)),
                        ),
                        mini: true,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: theme.colorScheme.primary, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.elliptical(5, 5))),
                        title: CustomText(content: _vw.UserFullName!),
                        subtitle: CustomText(content: (_vw.UserName! + (_vw.ClassName!.isNotEmpty ? (" | ") + _vw.ClassName! : "") + (_vw.DivisionName!.isNotEmpty ? (" | ") + _vw.DivisionName! : ""))),
                        onTap: () => {},
                        margin: EdgeInsets.all(2.0),
                      );
                    },
                  ),
                ),
              );
            }
            return CustomMessage(msg: "No Users Available");
          }
          return CustomMessage(msg: "No Users Available");
        }
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
        content: userInitial.toUpperCase(),
        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      backgroundColor: Colors.teal.shade100,
      foregroundColor: Colors.teal,
    );
  }
}
