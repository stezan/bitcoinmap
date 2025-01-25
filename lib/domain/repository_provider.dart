import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository.dart';
import '../data/source/elements_data_source.dart';
import 'package:http/http.dart' as http;

final bitcoinRepositoryProvider = Provider<BitcoinShopsRepository>((ref) {
  final httpClient = http.Client();
  final dataSource = BitcoinShopsDataSource(httpClient: httpClient);
  return BitcoinShopsRepository(elementsDataSource: dataSource);
});
