import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

Widget customCardTextField({
  labelText,
  required TextEditingController controller,
  keyboardType,
  prefixText,
  inputAction,
  FocusNode? currentFocus,
  hintText,
  showError = false,
  errorText,
  // nextFocus,
  maxLines = 1,
  // required Function filedFocus,
  onTap,
  maskFormatter,
  enable,
  onChanged,
}) {
  return TextFormField(
    style: const TextStyle(),
    controller: controller,
    focusNode: currentFocus,
    onTap: onTap,
    textCapitalization: TextCapitalization.sentences,
    onChanged: onChanged,
    inputFormatters: [maskFormatter],
    onFieldSubmitted: (term) {
      // filedFocus(currentFocus, nextFocus);
    },
    enabled: enable,
    maxLines: maxLines,
    textInputAction: inputAction,
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        // fillColor: Colors.greenAccent,
        hintText: hintText,
        hintStyle: TextStyle(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.green, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        prefixText: prefixText,
        errorText: showError ? errorText : null),
    cursorColor: Colors.green,
    keyboardType: keyboardType,
  );
}

Widget customLabelTextField({
  labelText,
  required TextEditingController controller,
  keyboardType,
  prefixText,
  inputAction,
  FocusNode? currentFocus,
  hintText,
  showError = false,
  errorText,
  // nextFocus,
  maxLines = 1,
  enabled,
  // required Function filedFocus,
  onTap,
  onChanged,
}) {
  return TextFormField(
    style: TextStyle(),
    controller: controller,
    focusNode: currentFocus,
    onTap: onTap,
    textCapitalization: TextCapitalization.sentences,
    onChanged: onChanged,
    onFieldSubmitted: (term) {
      // filedFocus(currentFocus, nextFocus);
    },
    enabled: enabled,
    maxLines: maxLines,
    textInputAction: inputAction,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        // fillColor: Colors.greenAccent,
        hintText: hintText,
        hintStyle: TextStyle(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.green, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        prefixText: prefixText,
        errorText: showError ? errorText : null),
    cursorColor: Colors.green,
    keyboardType: keyboardType,
  );
}

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'id': build.id
  };
}

var linearGradient = [
  const LinearGradient(
    colors: [Color(0xff374AAA), Color(0xff64B6FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.cyan, Colors.green],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.red, Colors.white],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.purpleAccent, Colors.purple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.black, Colors.white],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.pinkAccent, Colors.pink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.cyan, Colors.lightBlue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.green, Colors.grey],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.orangeAccent, Colors.orange],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
  const LinearGradient(
    colors: [Colors.yellow, Colors.yellowAccent],
    begin: Alignment.centerLeft,
    end: Alignment.bottomLeft,
  ),
];
