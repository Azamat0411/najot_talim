import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constant/const.dart';
import 'entities/hive_db.dart';

initHive() async {

  await Hive.initFlutter();

  debugPrint("Hive init start: ${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().millisecond}");

  Hive.registerAdapter(HiveDBAdapter());
  Hive.registerAdapter(CountryModelAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(CountriesAdapter());
  Hive.registerAdapter(ContinentAdapter());

  await Hive.openBox<HiveDB>(db);
  Box<HiveDB> box = Hive.box(db);
  HiveDB? hiveDB = box.get(db);
  if(hiveDB == null){
    box.put(db, HiveDB());
  }

  debugPrint("Hive init end: ${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().millisecond}");
}