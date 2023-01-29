import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:najot_talim/presentation/route/route.dart';
import 'package:najot_talim/presentation/route/routes.dart';
import 'package:najot_talim/presentation/route/routes_const.dart';
import 'package:najot_talim/presentation/screen/home/download/bloc/bloc.dart';
import 'package:najot_talim/presentation/screen/internetHelper/connectivity_provider.dart';
import 'package:provider/provider.dart';

import 'core/constant/app_colors.dart';
import 'hive_init.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  await initHive();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
    Provider(
      create: (_) => DownloadBloc(),
      dispose: (_, DownloadBloc bloc) => bloc.close(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: RouteList.splash,
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: builder, settings: settings);
      },
      theme: ThemeData(
        primarySwatch: blue,
      ),
    );
  }
}
