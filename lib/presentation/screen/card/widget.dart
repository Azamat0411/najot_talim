

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
  onChanged,
}) {
  return TextFormField(
    style:TextStyle(),
    controller: controller,
    focusNode: currentFocus,
    onTap: onTap,
    textCapitalization: TextCapitalization.sentences,
    onChanged: onChanged,
 inputFormatters: [maskFormatter],
    onFieldSubmitted: (term) {
      // filedFocus(currentFocus, nextFocus);
    },

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
  // required Function filedFocus,
  onTap,
  onChanged,
}) {
  return TextFormField(
    style:TextStyle(),
    controller: controller,
    focusNode: currentFocus,
    onTap: onTap,
    textCapitalization: TextCapitalization.sentences,
    onChanged: onChanged,
    onFieldSubmitted: (term) {
      // filedFocus(currentFocus, nextFocus);
    },

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
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'systemFeatures': build.systemFeatures,
    'displaySizeInches':
    ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
    'displayWidthPixels': build.displayMetrics.widthPx,
    'displayWidthInches': build.displayMetrics.widthInches,
    'displayHeightPixels': build.displayMetrics.heightPx,
    'displayHeightInches': build.displayMetrics.heightInches,
    'displayXDpi': build.displayMetrics.xDpi,
    'displayYDpi': build.displayMetrics.yDpi,
  };
}

