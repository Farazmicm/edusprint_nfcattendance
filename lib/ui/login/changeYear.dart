import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/enum/enum.dart';
import 'package:nfcdemo/models/dropdownModel.dart';
import 'package:nfcdemo/services/apiFunctions.dart';
import 'package:nfcdemo/utilities/common.dart';
import 'package:nfcdemo/utilities/utility.dart';
import 'package:nfcdemo/widgets/layoutWidget.dart';
import 'package:nfcdemo/widgets/loginUI.dart';
import 'package:nfcdemo/widgets/widgets.dart';

import '../../utilities/constants.dart';

class ChangeYear extends StatefulWidget {
  const ChangeYear({Key? key, this.appBarTitle}) : super(key: key);

  final String? appBarTitle;

  @override
  _ChangeYearState createState() => _ChangeYearState();
}

class _ChangeYearState extends State<ChangeYear> {
  String selectedValueForStudent = UserID;
  String selectedValueForStudentYear = yearMasterID;

  final branchFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<dynamic>> studentItems = [];
  List<DropdownMenuItem<dynamic>> studentYearItems = [];

  @override
  void initState() {
    filDropDownForBranchSelection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LayoutWidget(
        appTitle: widget.appBarTitle ?? "Change year",
        child: LoginUI(
          isUseWithAppbar: false,
          height: .9,
          child: Form(
            key: branchFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ImageWithAsset(
                    path: 'images/logo.png',
                    height: 58,
                    width: 58,
                    boxFit: BoxFit.fill,
                  ),
                ),
                CustomDropdownButtonFormField(
                  labelText: "Select Student",
                  items: studentItems,
                  selectedValue: selectedValueForStudent,
                  validator: (value) =>
                      value == null ? "Please select student name" : null,
                  onChanged: (val) async {
                    setState(() {
                      selectedValueForStudent = val;
                    });
                  },
                ),
                SizedBox(),
                CustomDropdownButtonFormField(
                  labelText: "Select Year",
                  items: studentYearItems,
                  selectedValue: selectedValueForStudentYear,
                  validator: (value) =>
                      value == null ? "Please select student year" : null,
                  onChanged: (val) async {
                    setState(() {
                      selectedValueForStudentYear = val;
                    });
                  },
                ),
                SizedBox(),
                CustomElevatedButton(
                  text: "Continue",
                  width: size.width * .6,
                  onBtnPressed: () => gotoHome(),
                ),
                SizedBox(),
                CopyRightText(),
                SizedBox(),
              ],
            ),
          ),
        ));
  }

  void gotoHome() async {
    try {
      ProgressDialog dialog = ProgressDialog(
        context,
        blur: 2,
        dialogTransitionType: DialogTransitionType.Shrink,
        message: CustomText(content: "Please wait..."),
        dialogStyle: DialogStyle(
          elevation: 5,
        ),
      );
      if (await Utility.isInternet()) {
        if (branchFormKey.currentState!.validate()) {
          dialog.show();

          Map<String, dynamic> oResponse = await branchSelectionPostNew(
              selectedValueForStudent, selectedValueForStudentYear);

          if (oResponse.isNotEmpty &&
              oResponse.containsKey("Success") &&
              oResponse["Success"] == true) {
            Map<String, dynamic> oResponseData =
                convert.jsonDecode(oResponse["ResponseData"]);
            if (oResponseData.isNotEmpty &&
                oResponseData.containsKey("Result")) {
              var oFinalResult = oResponseData["Result"];
              insertStudentFullDetail(oFinalResult);
              setConstantValue();

              dialog.dismiss();
              Navigator.pushReplacementNamed(context, "dashboard");
            } else {
              dialog.dismiss();
              showCustomToast(context, "Something went wrong.");
            }
          } else {
            dialog.dismiss();
            showCustomToast(context, "Something went wrong.");
          }
        }
      } else {
        showCustomToast(context, null);
      }
    } catch (e) {
      throw (syncError("gotoHome", e));
    }
  }

  void filDropDownForBranchSelection() async {
    try {
      var studentLst = List.from(convert.jsonDecode(
              await Utility.readLocalStorage(
                  localStorageKeyEnum.Students.toString())))
          .map((e) => Students.fromJson(e))
          .toList();

      var studentYearLst = List.from(convert.jsonDecode(
              await Utility.readLocalStorage(
                  localStorageKeyEnum.StudentYears.toString())))
          .map((e) => StudentYears.fromJson(e))
          .toList();

      setState(() {
        studentItems = studentLst.map((e) {
          return DropdownMenuItem(
            child: Text(e.UserFullName),
            value: e.UserID.toString(),
          );
        }).toList();
        studentYearItems = studentYearLst.map((e) {
          return DropdownMenuItem(
            child: Text(e.Description),
            value: e.YearMasterID.toString(),
          );
        }).toList();
      });
    } catch (e) {
      //throw (syncError("filDropDownForBranchSelection", e));
    }
  }
}
