import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import '../../presentation/component/text_widget.dart';
import '../../presentation/route/route.dart';
import '../constant/app_colors.dart';

flash(message, Color color, {FlashPosition? position}) {
  BuildContext? context = NavigationService.navigatorKey.currentContext;
  if (context != null) {
    showFlash(
        transitionDuration: const Duration(seconds: 0),
        context: context,
        duration: const Duration(seconds: 3),
        builder: (_, controller) {
          return Flash(
              enableVerticalDrag: false,
              barrierDismissible: true,
              backgroundColor: color,
              controller: controller,
              position: position??FlashPosition.top,
              behavior: FlashBehavior.floating,
              borderRadius: BorderRadius.circular(5),
              margin: EdgeInsets.symmetric(
                  vertical:
                      MediaQuery.of(context).padding.top + 10,
                  horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextWidget(
                        textAlign: TextAlign.center,
                        text: message,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        textColor: kPrimaryWhiteColor),
                  ),
                ],
              ));
        });
  }
}
