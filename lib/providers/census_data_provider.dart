import 'package:ecensus_nepal/models/census_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final censusDataProvider = StateProvider<Census>((ref) => Census().initial());
