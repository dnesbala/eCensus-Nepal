// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'census_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CensusDataAdapter extends TypeAdapter<CensusData> {
  @override
  final int typeId = 0;

  @override
  CensusData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CensusData()
      ..province = fields[0] as String?
      ..district = fields[1] as String?
      ..municipality = fields[2] as String?
      ..wardNo = fields[3] as int?
      ..tole = fields[4] as String?
      ..familyHeadName = fields[5] as String?
      ..familyHeadContact = fields[6] as int?
      ..ownHouse = fields[7] as String?
      ..baseHouseMade = fields[8] as String?
      ..isDeathWithinPast12Months = fields[9] as bool?
      ..noOfDeaths = fields[10] as int?
      ..deathPersons = (fields[11] as List?)?.cast<dynamic>()
      ..individualDetail = (fields[12] as List?)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, CensusData obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.province)
      ..writeByte(1)
      ..write(obj.district)
      ..writeByte(2)
      ..write(obj.municipality)
      ..writeByte(3)
      ..write(obj.wardNo)
      ..writeByte(4)
      ..write(obj.tole)
      ..writeByte(5)
      ..write(obj.familyHeadName)
      ..writeByte(6)
      ..write(obj.familyHeadContact)
      ..writeByte(7)
      ..write(obj.ownHouse)
      ..writeByte(8)
      ..write(obj.baseHouseMade)
      ..writeByte(9)
      ..write(obj.isDeathWithinPast12Months)
      ..writeByte(10)
      ..write(obj.noOfDeaths)
      ..writeByte(11)
      ..write(obj.deathPersons)
      ..writeByte(12)
      ..write(obj.individualDetail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CensusDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
