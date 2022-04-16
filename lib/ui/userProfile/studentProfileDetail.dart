import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/database_mng/repository/userdetails_repository.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/theme/customTheme.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/global_context.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../../utilities/constants.dart';

class StudentProfileDetail extends StatefulWidget {
  const StudentProfileDetail({Key? key}) : super(key: key);

  @override
  _StudentProfileDetailState createState() => _StudentProfileDetailState();
}

class _StudentProfileDetailState extends State<StudentProfileDetail> {
  var customTheme = CustomTheme.lightTheme;
  var lstWidget = <Widget>[];
  var lstProfileInfoWidget = <Widget>[];

  final lstImage = <Image>[];
  bool _isNodata = false;

  @override
  void initState() {
    filProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isNodata
        ? CustomMessage()
        : SingleChildScrollView(
            controller: ScrollController(),
            padding: EdgeInsets.all(13),
            scrollDirection: Axis.vertical,
            child: Column(
              children: lstWidget,
            ),
          );
  }

  void filProfileData() async {
    try {
      if (await Utility.isInternet()) {
        ProgressDialog dialog = ProgressDialog(
          context,
          blur: 2,
          dialogTransitionType: DialogTransitionType.Shrink,
          message: CustomText(content: "Please wait..."),
          dialogStyle: DialogStyle(
            elevation: 5,
          ),
          dismissable: false,
        );
        dialog.show();

        /*Map<String, dynamic> oStudentFullDetail = convert.jsonDecode(
            await Utility.readLocalStorage(
                localStorageKeyEnum.StudentFullDetail.toString()));*/
        var oCurrentUser = await UserDetailsRepository.getCurrentUserDetails();
        /*Map<String, dynamic> oVWStudentFullDetailNullable =
            oStudentFullDetail["VWStudentFullDetailNullable"];*/

        if (oCurrentUser != null && oCurrentUser.UserID > 0) {
          Map<String, dynamic> oResponse = await getStudentProfileData();

          setState(() {
            //#region for swipe list
            lstImage.add(Image(
              image: NetworkImage(imageFileHostedPath + oCurrentUser.UserImage),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return ImageWithAsset(
                  path: 'images/imgNotAvailable.png',
                );
              },
            ));
            //#endregion
            var theme = Theme.of(context);
            Size size = MediaQuery.of(context).size;

            lstWidget.add(Container(
              height: 50,
            ));
            lstWidget.add(Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(
                        left: 13,
                        top: 70.0,
                        right: 13.0,
                        bottom: 13.0,
                      ),
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            content: oCurrentUser.UserFullName,
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call_rounded,
                                color: theme.colorScheme.primary,
                                size: 16.0,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              CustomText(
                                content:
                                    oCurrentUser.ContactMobileNumber.isNotEmpty
                                        ? oCurrentUser.ContactMobileNumber
                                        : "NA",
                                style: theme.textTheme.caption,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: theme.colorScheme.primary,
                                size: 16.0,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              CustomText(
                                content: oCurrentUser.EmailID.isNotEmpty
                                    ? oCurrentUser.EmailID
                                    : "NA",
                                style: theme.textTheme.caption,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          ElevatedButton.icon(
                              onPressed: () async =>
                                  await getWebUrlAndOpenWebView(),
                              icon: Icon(Icons.edit_note_sharp),
                              label: CustomTextSingleLine(
                                content: "Edit Profile",
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 7.0, right: 7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: lstProfileInfoWidget,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -40.0,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: theme.colorScheme.primary, width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(2.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              clipBehavior: Clip.antiAlias,
                              child: ImageWithNetwork(
                                url: oCurrentUser.UserImage,
                                boxFit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              ))),
                      onTap: () {
                        swipeImage(context, lstImage, 0, false);
                      },
                    ),
                  )
                ]));

            if (oResponse.isNotEmpty) {
              oResponse.remove("EmailID");
              oResponse.remove("Contact Number");
              lstProfileInfoWidget.add(Divider(
                thickness: 1,
              ));
              oResponse.forEach((key, value) {
                lstProfileInfoWidget.add(
                  key == "Address"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              content: key,
                              style: customTheme.textTheme.headline6,
                            ),
                            CustomText(
                              content: value ?? "-",
                              style: customTheme.textTheme.caption,
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              content: key,
                              style: customTheme.textTheme.headline6,
                            ),
                            CustomText(
                              content: value ?? "-",
                              style: customTheme.textTheme.caption,
                            )
                          ],
                        ),
                );
                lstProfileInfoWidget.add(Divider(
                  thickness: 1,
                ));
              });
            }
          });
        } else {
          setState(() {
            _isNodata = !_isNodata;
          });
        }
        dialog.dismiss();
      } else {
        showCustomToast(context, null);
      }
    } catch (e) {
      await syncError("filProfileData", e);
    }
  }

  Future<void> getWebUrlAndOpenWebView() async {
    if (await Utility.isInternet()) {
      ProgressDialog dialog = ProgressDialog(
        GlobalContext.navigatorKey.currentContext!,
        blur: 2,
        dialogTransitionType: DialogTransitionType.Shrink,
        message: CustomText(content: "Please wait..."),
        dialogStyle: DialogStyle(
          elevation: 5,
        ),
        dismissable: false,
      );
      dialog.show();
      await ecampusWebFromURL("editprofilerequest").then((value) {
        dialog.dismiss();
        Navigator.pushNamed(
          GlobalContext.navigatorKey.currentContext!,
          "webviewcall",
          arguments: value + '###' + "Edit Student Profile",
        );
      });
    } else {
      showCustomToast(GlobalContext.navigatorKey.currentContext!, null);
    }
  }
}
