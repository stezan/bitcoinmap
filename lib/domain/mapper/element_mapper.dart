import '../../data/model/element.dart';
import '../model/bitcoin_shop_model.dart';

BitcoinShopModel? mapToDomainModel(BitcoinShop element) {
  if (element.osmJson.tags == null) return null;
  if (element.osmJson.tags!['name'] == null) return null;

  return BitcoinShopModel(
    id: element.id,
    name: element.osmJson.tags?['name'] ?? 'Unknown',
    latitude: element.osmJson.lat ?? 0,
    longitude: element.osmJson.lon ?? 0,
    shopType: element.osmJson.tags?['shop'],
    description: element.osmJson.tags?['description'],
    website: element.osmJson.tags?['contact:website'],
    phoneNumber: element.osmJson.tags?['phone'],
    email: element.osmJson.tags?['email'],
    postalCode: element.osmJson.tags?['addr:postcode'],
    street: element.osmJson.tags?['addr:street'],
    houseNumber: element.osmJson.tags?['addr:housenumber'],
    city: element.osmJson.tags?['addr:city'],
  );
}
