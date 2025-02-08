import 'package:bitcoin_map/domain/repository_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'filter_provider.dart';
import 'model/bitcoin_shop_model.dart';
import 'model/filter_param_model.dart';

final filteredShopsProvider = FutureProvider<List<BitcoinShopModel>>((ref) async {
  final bitcoinShops = await ref.watch(_bitcoinShopsProvider.future);
  final filter = ref.watch(filterProvider);
  return compute(filterElements, FilterParams(bitcoinShops, filter));
});

final _bitcoinShopsProvider = FutureProvider<List<BitcoinShopModel>>((ref) async {
  final repository = ref.read(bitcoinRepositoryProvider);
  final elements = await repository.fetchBitcoinShops();
  return elements;
});

List<BitcoinShopModel> filterElements(FilterParams params) {
  final elements = params.elements;
  final filter = params.filter;

  if (filter.shopType == null && filter.bounds == null) {
    return elements;
  }

  return elements.where((element) {
    final matchesBounds = filter.bounds?.contains(LatLng(element.latitude, element.longitude)) ?? true;
    final matchesShopType =
        filter.shopType == null || (element.shopType != null && element.shopType!.toLowerCase() == filter.shopType!.toLowerCase());
    return matchesBounds && matchesShopType;
  }).toList();
}
