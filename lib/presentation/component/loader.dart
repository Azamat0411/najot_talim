import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constant/app_colors.dart';

class Loader extends StatelessWidget {

  final Color? color;

  const Loader({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Center(
            child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                    color: color,
                    strokeWidth: 3)))
        : Center(
            child: CupertinoActivityIndicator(
                radius: 15,
                color: color??kPrimaryBlackColor));
  }
}
