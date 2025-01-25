import 'dart:convert';
import 'package:bitcoin_map/data/model/element.dart';
import 'package:http/http.dart' as http;

class BitcoinShopsDataSource {
  final http.Client httpClient;

  BitcoinShopsDataSource({required this.httpClient});

  Future<List<BitcoinShop>> fetchBitcoinShops() async {
    final response = await httpClient.get(Uri.parse('https://api.btcmap.org/v2/elements'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load elements');
    }

    final List<dynamic> bitcoinShopsJson = json.decode(response.body);
    return bitcoinShopsJson.map((json) => BitcoinShop.fromJson(json)).toList();
  }
}
