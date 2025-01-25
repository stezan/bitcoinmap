import 'package:bitcoin_map/data/model/shop_type.dart';
import 'package:bitcoin_map/data/source/elements_data_source.dart';

import '../domain/mapper/element_mapper.dart';
import '../domain/model/bitcoin_shop_model.dart';
import 'model/element.dart';

class BitcoinShopsRepository {
  final BitcoinShopsDataSource elementsDataSource;

  BitcoinShopsRepository({required this.elementsDataSource});

  List<BitcoinShop> bitcoinShops = [];

  Future<List<BitcoinShopModel>> fetchBitcoinShops() async {
    if (bitcoinShops.isEmpty) {
      bitcoinShops = await elementsDataSource.fetchBitcoinShops();
    }
    return bitcoinShops.map((element) => mapToDomainModel(element)).toList();
  }

  Future<List<ShopType>> fetchShopTypes() async {
    if (bitcoinShops.isEmpty) {
      bitcoinShops = await elementsDataSource.fetchBitcoinShops();
    }
    return bitcoinShops.map((element) => ShopType(name: element.osmJson.tags?['shop'] ?? 'Unknown')).toSet().toList();
  }
}
