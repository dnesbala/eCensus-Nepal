import 'package:hive/hive.dart';

part 'census_data_model.g.dart';

@HiveType(typeId: 0)
class CensusData extends HiveObject {
  @HiveField(0)
  String? province;

  @HiveField(1)
  String? district;

  @HiveField(2)
  String? municipality;

  @HiveField(3)
  int? wardNo;

  @HiveField(4)
  String? tole;

  @HiveField(5)
  String? familyHeadName;

  @HiveField(6)
  int? familyHeadContact;

  @HiveField(7)
  String? ownHouse;

  @HiveField(8)
  String? baseHouseMade;

  @HiveField(9)
  bool? isDeathWithinPast12Months;

  @HiveField(10)
  int? noOfDeaths;

  @HiveField(11)
  List<dynamic>? deathPersons;

  @HiveField(12)
  List<dynamic>? individualDetail;

  @HiveField(13)
  String? drinkingWaterSource;

  @HiveField(14)
  String? foodHeatSource;

  @HiveField(15)
  String? lightSource;
}
