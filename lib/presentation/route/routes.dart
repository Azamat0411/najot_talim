import 'package:flutter/material.dart';
import 'package:najot_talim/entities/hive_db.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/home/card/card_add_screen.dart';
import 'package:najot_talim/presentation/screen/home/card/card_edit_screen.dart';
import 'package:najot_talim/presentation/screen/home/country/card_view.dart';
import 'package:najot_talim/presentation/screen/home/home_screen.dart';

import '../screen/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.home: (context) => const HomeScreen(),
        RouteList.splash: (context) => const SplashScreen(),
        RouteList.cardAdd: (context) => const CardAddScreen(),
        RouteList.cardView: (context) =>
            CountryCardView(country: setting.arguments as Countries),
        RouteList.cardEdit: (context) =>
            CardEditScreen(cardIdAndUserId: setting.arguments as List),
      };
}
