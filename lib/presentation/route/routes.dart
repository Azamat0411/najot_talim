import 'package:flutter/material.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/home/download/download_file.dart';
import 'package:najot_talim/presentation/screen/home/home_screen.dart';

import '../screen/splash/splash_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.home: (context) => const HomeScreen(),
        RouteList.splash: (context) => const SplashScreen(),
        RouteList.downland: (context) => const DownloadFile(),
      };
}

