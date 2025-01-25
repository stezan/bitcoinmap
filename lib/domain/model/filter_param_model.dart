import 'bitcoin_shop_model.dart';

class FilterParams {
  final List<BitcoinShopModel> elements;
  final String? filter;

  FilterParams(this.elements, this.filter);
}
