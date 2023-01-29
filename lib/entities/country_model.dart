part of 'hive_db.dart';

@HiveType(typeId: 1)
class CountryModel {

  @HiveField(0)
  Data? data;

  CountryModel({this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

@HiveType(typeId: 2)
class Data {

  @HiveField(0)
  List<Countries>? countries;

  Data({this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    } else {
      countries = [];
    }
  }
}

@HiveType(typeId: 3)
class Countries {

  @HiveField(0)
  String? code;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? phone;

  @HiveField(3)
  Continent? continent;

  @HiveField(4)
  String? capital;

  @HiveField(5)
  String? currency;

  @HiveField(6)
  String? emoji;

  Countries(
      {this.code,
      this.name,
      this.phone,
      this.continent,
      this.capital,
      this.currency,
      this.emoji});

  Countries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    phone = json['phone'];
    continent = json['continent'] != null
        ? Continent.fromJson(json['continent'])
        : null;
    capital = json['capital'];
    currency = json['currency'];
    emoji = json['emoji'];
  }
}

@HiveType(typeId: 4)
class Continent {

  @HiveField(0)
  String? code;

  @HiveField(1)
  String? name;

  Continent({this.code, this.name});

  Continent.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }
}
