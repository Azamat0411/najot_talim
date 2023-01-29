import 'package:dio/dio.dart';
import 'package:najot_talim/domain/rest.dart';
import 'api_client_impl.dart';

class ApiClient extends ApiClientImpl {
  final _rest = Rest();

  // @override
  // Future<bool?> dashboard(String fromDate, String toDate) async {
  //   Map<String, dynamic> headers = {'token': GetStorage().read('token')};
  //
  //   Map<String, dynamic> params = {'from_date': fromDate, 'to_date': toDate};
  //
  //   final _result =
  //    await _rest.request(path: "dashboard", header: headers, params: params);
  //
  //   if (_result == null) {
  //     return false;
  //   }
  //
  //   final value = DashboardResponse.fromJson(_result.data!);
  //
  //   Box<HiveDB> hive = Hive.box(db);
  //   HiveDB? hiveDB = hive.get(db);
  //   hiveDB?.dashboardResponse = value;
  //   hive.put(db, hiveDB ?? HiveDB());
  //
  //   return true;
  // }
}
