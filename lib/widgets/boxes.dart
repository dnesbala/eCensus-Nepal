import 'package:ecensus_nepal/models/census_data_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<CensusData> getCensusData() => Hive.box<CensusData>('censusdata');
}
