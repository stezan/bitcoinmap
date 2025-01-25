import 'package:flutter_map/flutter_map.dart';
import 'bitcoin_shop_model.dart';

class MarkerWithData extends Marker {
  final BitcoinShopModel element;

  const MarkerWithData({
    required super.key,
    required this.element,
    required super.point,
    required super.child,
    super.width,
    super.height,
    super.alignment,
    super.rotate,
  });
}
