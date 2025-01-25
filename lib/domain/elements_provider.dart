import 'package:bitcoin_map/domain/repository_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'filter_provider.dart';
import 'model/bitcoin_shop_model.dart';
import 'model/filter_param_model.dart';
import 'model/marker_with_data_model.dart';

final filteredMarkersProvider = FutureProvider<List<MarkerWithData>>((ref) async {
  final bitcoinShops = await ref.watch(_bitcoinShopsProvider.future);
  final filter = ref.watch(filterProvider);

  final filteredMarkers = await compute(filterElements, FilterParams(bitcoinShops, filter));

  return compute(generateMarkers, filteredMarkers);
});

final _bitcoinShopsProvider = FutureProvider<List<BitcoinShopModel>>((ref) async {
  final repository = ref.read(bitcoinRepositoryProvider);
  final elements = await repository.fetchBitcoinShops();
  return elements;
});

List<MarkerWithData> generateMarkers(List<BitcoinShopModel> elements) {
  return elements.map((element) {
    return MarkerWithData(
      element: element,
      key: ValueKey(element.id),
      width: 65.0,
      height: 65.0,
      alignment: Alignment.topCenter,
      point: LatLng(element.latitude, element.longitude),
      child: Image.asset('assets/images/bitcoin_pin.png'),
    );
  }).toList();
}

List<BitcoinShopModel> filterElements(FilterParams params) {
  final elements = params.elements;
  final filter = params.filter;

  return filter == null ? elements : elements.where((element) => element.shopType != null && element.shopType!.toLowerCase() == filter).toList();
}
