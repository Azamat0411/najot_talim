import 'package:hive/hive.dart';

part 'hive_db.g.dart';
part 'country_model.dart';

@HiveType(typeId: 0)
class HiveDB{

  /// typeId 1-3
  @HiveField(0)
  CountryModel? countryModel;

  HiveDB({this.countryModel});

}