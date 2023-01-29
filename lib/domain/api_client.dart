import 'package:hive/hive.dart';
import 'package:najot_talim/domain/rest.dart';
import 'package:najot_talim/entities/hive_db.dart';

import '../core/constant/const.dart';
import 'api_client_impl.dart';

class ApiClient extends ApiClientImpl {
  final _rest = Rest();

  @override
  Future<bool?> getCountries() async {
    final result = await _rest.request(
        baseUrl: 'https://najot-exam.free.mockoapp.net/countries', path: "");

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
}
