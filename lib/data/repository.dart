import 'package:bitcoin_map/data/model/community.dart';
import 'package:bitcoin_map/data/model/shop_type.dart';
import 'package:bitcoin_map/data/source/elements_data_source.dart';
import 'package:bitcoin_map/domain/model/community_model.dart';

import '../domain/mapper/bitcoin_shop_mapper.dart';
import '../domain/mapper/community_mapper.dart';
import '../domain/model/bitcoin_shop_model.dart';
import 'model/bitcoin_shop.dart';

class BitcoinShopsRepository {
  final BitcoinShopsDataSource elementsDataSource;

  BitcoinShopsRepository({required this.elementsDataSource});

  List<BitcoinShop> bitcoinShops = [];
  List<Community> communities = [];

  Future<List<BitcoinShopModel>> fetchBitcoinShops() async {
    if (bitcoinShops.isEmpty) {
      bitcoinShops = await elementsDataSource.fetchBitcoinShops();
    }
    return bitcoinShops.map((element) => mapToDomainModel(element)).whereType<BitcoinShopModel>().toList();
  }

  Future<List<ShopType>> fetchShopTypes() async {
    if (bitcoinShops.isEmpty) {
      bitcoinShops = await elementsDataSource.fetchBitcoinShops();
    }
    return bitcoinShops.map((element) => ShopType(name: element.osmJson.tags?['shop'] ?? 'Unknown')).toSet().toList();
  }

  Future<List<CommunityModel>> fetchCommunities() async {
    if (communities.isEmpty) {
      communities = await elementsDataSource.fetchCommunities();
    }
    return communities.map((community) => mapCommunity(community)).whereType<CommunityModel>().toList();
  }
}
