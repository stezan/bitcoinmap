import 'package:bitcoin_map/domain/filter_provider.dart';

import 'bitcoin_shop_model.dart';

class FilterParams {
  final List<BitcoinShopModel> elements;
  final FilterState filter;

  FilterParams(this.elements, this.filter);
}
