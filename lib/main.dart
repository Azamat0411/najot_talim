import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:najot_talim/presentation/route/route.dart';
import 'package:najot_talim/presentation/route/routes.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/internetHelper/connectivity_provider.dart';
import 'package:provider/provider.dart';

import 'hive_init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  await initHive();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: RouteList.splash,
      builder: (context, child) {
        return child ?? Container();
      },
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: builder, settings: settings);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
