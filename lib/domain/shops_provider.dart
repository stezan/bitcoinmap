import 'package:bitcoin_map/domain/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/bitcoin_shop_model.dart';

final shopsProvider = FutureProvider<List<BitcoinShopModel>>((ref) async {
  final repository = ref.read(bitcoinRepositoryProvider);
  final elements = await repository.fetchBitcoinShops();
  elements.sort((a, b) => b.reliability.compareTo(a.reliability));
  return elements;
});
