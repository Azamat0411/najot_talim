import 'dart:async';

import 'package:flutter/material.dart';

import '../../route/route.dart';
import '../../route/routes_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void didChangeDependencies() {
    openNextPage(context);
    super.didChangeDependencies();
  }

  openNextPage(BuildContext context) async {
    Timer(const Duration(seconds: 2), () async {
        NavigationPages().pushReplacementNamed(RouteList.home);
    });
  }
}
