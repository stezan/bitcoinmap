import '../../data/model/element.dart';
import '../model/bitcoin_shop_model.dart';

BitcoinShopModel mapToDomainModel(BitcoinShop element) {
  return BitcoinShopModel(
    id: element.id,
    latitude: element.osmJson.lat ?? 0,
    longitude: element.osmJson.lon ?? 0,
    shopType: element.osmJson.tags?['shop'],
    name: element.osmJson.tags?['name'],
    description: element.osmJson.tags?['description'],
    website: element.osmJson.tags?['contact:website'],
    phoneNumber: element.osmJson.tags?['phone'],
    postalCode: element.osmJson.tags?['addr:postcode'],
    street: element.osmJson.tags?['addr:street'],
    houseNumber: element.osmJson.tags?['addr:housenumber'],
    city: element.osmJson.tags?['addr:city'],
  );
}
