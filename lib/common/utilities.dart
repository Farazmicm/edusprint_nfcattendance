import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/common/deviceinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;

class Utility {
  //Check Internet Connection
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }

  static Future<bool> writeLocalStorage(
      String localStorageKey, String value) async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.setString(localStorageKey, value);
  }

  static Future<String> readLocalStorage(String localStorageKey) async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(localStorageKey) ?? "";
  }

  static Future<bool> removeLocalStorageKey(String localStorageKey) async {
    var localStorage = await SharedPreferences.getInstance();
    return localStorage.remove(localStorageKey);
  }

  static Future<bool> clearLocalStorage() async {
    late SharedPreferences localStorage;
    localStorage = await SharedPreferences.getInstance();
    return localStorage.clear();
  }
}

Future<ToastFuture> showCustomToast(BuildContext context, String? msg) async {
  return showToast(
    msg ?? 'Some error occured, please try after sometime.',
    context: context,
    axis: Axis.horizontal,
    alignment: Alignment.center,
    position: StyledToastPosition.top,
    toastHorizontalMargin: 20,
    fullWidth: true,
    duration: Duration(seconds: 3),
  );
}

Future<AwesomeDialog> customAlertForError(
    BuildContext context, String title, String desc) async {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.SCALE,
      headerAnimationLoop: true,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
      btnOkColor: Colors.red)
    ..show();
}


String shortDate(String dateTime,String dFormat) {
  final dateFormat = new DateFormat(dFormat);
  return dateFormat.format(DateTime.parse(dateTime));
}



Future<dynamic> setDeviceInformation() async{
  try{
    var oDeviceInfo = await DeviceInfo().initPlatformState();
    print("oDeviceInfo: "+convert.jsonEncode(oDeviceInfo));
    if(oDeviceInfo != null){
      await Utility.removeLocalStorageKey("DeviceInformation");

      await Utility.writeLocalStorage("DeviceInformation",convert.jsonEncode(oDeviceInfo));
    }
    return oDeviceInfo;
  }catch(e){
    print("setDeviceInformation: " + e.toString());
  }
}


class CustomTextField1 extends StatelessWidget {
  final TextEditingController? controller;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final MultiValidator validator;

  const CustomTextField1({
    Key? key,
    this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.isPassword = false,
    required this.textInputType,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      //width: size.width / 1.22,
      width: size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        controller: controller,
        obscureText: isPassword,
        keyboardType: textInputType,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: InputBorder.none,
          hintMaxLines: 1,
          hintStyle:
          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.isPassword = false,
    required this.textInputType,
    this.validator,
    this.isreadOnly = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool isPassword;
  final TextInputType textInputType;
  //final MultiValidator validator;
  final String? Function(String?)? validator;
  final bool isreadOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: isreadOnly,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          filled: false,
          fillColor: Colors.black.withOpacity(.05),
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0)),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  const CustomTextField2({
    Key? key,
    this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.isPassword = false,
    required this.textInputType,
    this.validator,
    this.isreadOnly = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  //final MultiValidator validator;
  final String? Function(String?)? validator;
  final bool isreadOnly;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.only(left: 15, right: 15, top: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: textInputType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: isreadOnly,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black54),
            filled: true,
            fillColor: Colors.black.withOpacity(.05),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
        required this.text,
        this.onBtnPressed,
        this.width,
        this.height,
        this.backgroundColor})
      : super(key: key);

  final VoidCallback? onBtnPressed;
  final double? height, width;
  final Widget text;
  final MaterialStateProperty<Color?>? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onBtnPressed,
      style: ButtonStyle(
        backgroundColor: backgroundColor,
      ),
      child: Container(
        alignment: Alignment.center,
        height: height ?? 44,
        width: width ?? size.width * .3,
        child: text,
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  const CustomDropdownButtonFormField(
      {Key? key,
        required this.labelText,
        required this.items,
        this.selectedValue,
        this.validator,
        this.onChanged})
      : super(key: key);

  final String labelText;
  final List<DropdownMenuItem<dynamic>> items;
  final String? selectedValue;
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        value: selectedValue,
        validator: validator,
        onChanged: onChanged,
        items: items);
  }
}

class CustomTextFieldDisable extends StatefulWidget {
  const CustomTextFieldDisable({
    Key? key,
    required this.labelText,
    required this.Value,
  }) : super(key: key);

  final String labelText;
  final String Value;

  @override
  _CustomTextFieldDisableState createState() => _CustomTextFieldDisableState();
}

class _CustomTextFieldDisableState extends State<CustomTextFieldDisable> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller=new TextEditingController(text:widget.Value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      style: GoogleFonts.lato(
        fontSize: 12,
        color: Colors.grey[800],
      ),
      enabled: false,
      minLines: 1,
      maxLines: 100,
      decoration: InputDecoration(
        labelText: widget.labelText + " :",
        labelStyle: TextStyle(fontSize: 20, color: Colors.grey.shade500),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(width: 1, color: Colors.grey.shade500),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      ),
    );
  }
}
