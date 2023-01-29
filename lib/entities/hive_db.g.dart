part of 'hive_db.dart';

class HiveDBAdapter extends TypeAdapter<HiveDB> {
  @override
  final int typeId = 0;

  @override
  HiveDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDB(
        countryModel: fields[0] as CountryModel?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDB obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.countryModel)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HiveDBAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class CountryModelAdapter extends TypeAdapter<CountryModel> {
  @override
  final int typeId = 1;

  @override
  CountryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryModel(
      data: fields[0] as Data?,
    );
  }

  @override
  void write(BinaryWriter writer, CountryModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountryModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      countries: (fields[0] as List?)?.cast<Countries>(),
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.countries)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DataAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class CountriesAdapter extends TypeAdapter<Countries> {
  @override
  final int typeId = 3;

  @override
  Countries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Countries(
      code: fields[0] as String?,
      name: fields[1] as String?,
      phone: fields[2] as String?,
      continent: fields[3] as Continent?,
      capital: fields[4] as String?,
      currency: fields[5] as String?,
      emoji: fields[6] as String?
    );
  }

  @override
  void write(BinaryWriter writer, Countries obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.continent)
      ..writeByte(4)
      ..write(obj.capital)
      ..writeByte(5)
      ..write(obj.currency)
      ..writeByte(6)
      ..write(obj.emoji)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CountriesAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class ContinentAdapter extends TypeAdapter<Continent> {
  @override
  final int typeId = 4;

  @override
  Continent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Continent(
      code: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Continent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.name)
    ;
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ContinentAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}