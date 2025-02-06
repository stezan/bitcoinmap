class BitcoinShopModel {
  final String id;
  final String name;
  final String? description;
  final double latitude;
  final double longitude;
  final String? shopType;
  final String? city;
  final String? houseNumber;
  final String? street;
  final String? postalCode;
  final String? phoneNumber;
  final String? website;

  String? getAddress() {
    if (street == null || houseNumber == null || postalCode == null || city == null) {
      return null;
    } else if (street == null) {
      return '$houseNumber, $postalCode $city';
    } else if (houseNumber == null) {
      return '$street, $postalCode $city';
    } else if (postalCode == null) {
      return '$street $houseNumber, $city';
    }
    return '$street $houseNumber, $postalCode $city';
  }

  BitcoinShopModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.shopType,
    required this.name,
    required this.description,
    required this.website,
    required this.phoneNumber,
    required this.postalCode,
    required this.street,
    required this.houseNumber,
    required this.city,
  });
}
