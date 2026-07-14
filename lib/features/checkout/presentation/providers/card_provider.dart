import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/card_local_datasource.dart';//'../data/datasources/card_local_datasource.dart';

final cardDataSourceProvider = Provider((ref) {
  return CardLocalDataSource();
});