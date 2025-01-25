import 'package:bitcoin_map/domain/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/shop_type.dart';

final shopTypesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.read(bitcoinRepositoryProvider);
  final shopTypes = await repository.fetchShopTypes();
  return shopTypes.map((shopType) => shopType.name).toSet().toList();
});
