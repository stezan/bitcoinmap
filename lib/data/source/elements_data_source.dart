import 'dart:convert';
import 'package:bitcoin_map/data/model/bitcoin_shop.dart';
import 'package:bitcoin_map/data/model/community.dart';
import 'package:http/http.dart' as http;

class BitcoinShopsDataSource {
  final http.Client httpClient;

  BitcoinShopsDataSource({required this.httpClient});

  Future<List<BitcoinShop>> fetchBitcoinShops() async {
    final response = await httpClient.get(Uri.parse('https://api.btcmap.org/v2/elements'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load elements');
    }

    final List<dynamic> bitcoinShopsJson = json.decode(utf8.decode(response.bodyBytes));
    return bitcoinShopsJson.map((json) => BitcoinShop.fromJson(json)).toList();
  }

  Future<List<Community>> fetchCommunities() async {
    final response = await httpClient.get(Uri.parse('https://api.btcmap.org/v2/areas'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load communities');
    }

    final List<dynamic> communitiesJson = json.decode(utf8.decode(response.bodyBytes));
    return communitiesJson.map((json) => Community.fromJson(json)).toList();
  }
}
