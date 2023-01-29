import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constant/app_colors.dart';

class TextFormWidget extends StatelessWidget {
  TextFormWidget({
    Key? key,
    required this.controller,
    this.focusNode,
    this.hingText,
    this.hingStyle,
    required this.radius,
    this.obscureText,
    this.maxLines,
    this.validator,
    this.inputFormatter,
    this.suffixIcon,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.textInputType,
    this.textInputAction,
    this.prefixText,
    this.style,
    this.prefixIcon,
    this.editable,
    this.fillColor,
    this.contentPadding
  }) : super(key: key);

  TextEditingController controller;
  FocusNode? focusNode;
  String? hingText;
  TextStyle? hingStyle;
  double radius;
  bool? obscureText;
  int? maxLines;
  FormFieldValidator<String>? validator;
  late List<TextInputFormatter>? inputFormatter;
  Widget? suffixIcon;
  Function(String)? onChanged;
  Function(String)? onSubmit;
  Function()? onTap;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  String? prefixText;
  TextStyle? style;
  Widget? prefixIcon;
  bool? editable;
  Color? fillColor;
  EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onSubmit,
      keyboardType: textInputType,
      inputFormatters: inputFormatter,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText??false,
      onTap: onTap,
      style: style,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        enabled: editable??true,
        fillColor: fillColor,
        filled: fillColor != null?true:false,
        contentPadding: contentPadding,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: blue,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: kPrimaryGreyColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: kPrimaryRedColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hingText,
        hintStyle: hingStyle
      ),
      onChanged: onChanged,
    );
  }
}
