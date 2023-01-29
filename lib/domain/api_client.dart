import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:najot_talim/domain/rest.dart';
import 'package:najot_talim/entities/card_model.dart';
import 'package:najot_talim/entities/hive_db.dart';

import '../core/constant/const.dart';
import '../presentation/screen/card/guid_gen.dart';
import '../presentation/screen/card/widget.dart';
import 'api_client_impl.dart';

class ApiClient extends ApiClientImpl {
  final _rest = Rest();

  @override
  Future<bool?> getCountries() async {
    final result = await _rest.request(baseUrl: 'https://najot-exam.free.mockoapp.net/countries', path: "");
    if (result == null) {
      return false;
    }

    final value = CountryModel.fromJson(result.data!);

    Box<HiveDB> hive = Hive.box(db);
    HiveDB? hiveDB = hive.get(db);
    hiveDB?.countryModel = value;
    hive.put(db, hiveDB ?? HiveDB());

    return true;
  }

 static Future<bool> addCard(CardModel cardModel, {String? cardNumber, String? cardName, String? cardExpired, String? cardOwner, String? cardType, int? gradient, String? cardId, String? deviceId}) async {
    try {
      var cardId = GUIDGen.generate();
      var token = GUIDGen.generate();
      await FirebaseFirestore.instance.collection(deviceId!).doc(cardId).set({
        "cardId": cardId,
        "gradient": gradient,
        "cardNumber": cardNumber,
        "cardName": cardName,
        "cardExpired": cardExpired,
        "cardOwner": cardOwner,
        "cardType": cardType,
        "userId": token,
      });
      return true;
    } catch (s) {
      return false;
    }
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

 static Future<Map<String, dynamic>> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
    // setState(() {
    //   _deviceData = deviceData;
    // });
    return deviceData;
  }
}
