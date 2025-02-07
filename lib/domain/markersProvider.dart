import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'elements_provider.dart';
import 'model/bitcoin_shop_model.dart';
import 'model/marker_with_data_model.dart';

final filteredMarkersProvider = FutureProvider<List<MarkerWithData>>((ref) async {
  final filteredMarkers = await ref.watch(filteredShopsProvider.future);
  return compute(generateMarkers, filteredMarkers);
});

List<MarkerWithData> generateMarkers(List<BitcoinShopModel> elements) {
  return elements
      .map((element) => MarkerWithData(
            element: element,
            key: ValueKey(element.id),
            width: 65.0,
            height: 65.0,
            alignment: Alignment.topCenter,
            point: LatLng(element.latitude, element.longitude),
            child: Image.asset('assets/images/bitcoin_pin.png'),
          ))
      .toList();
}
