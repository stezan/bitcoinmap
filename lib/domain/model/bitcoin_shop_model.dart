class BitcoinShopModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? description;
  final String? shopType;
  final String? city;
  final String? houseNumber;
  final String? street;
  final String? postalCode;
  final String? phoneNumber;
  final String? website;
  final String? email;
  final int reliability;

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
    required this.email,
    required this.street,
    required this.houseNumber,
    required this.city,
  }) : reliability = _calculateReliability(
          description,
          shopType,
          city,
          houseNumber,
          street,
          postalCode,
          phoneNumber,
          website,
        );

  static int _calculateReliability(
    String? description,
    String? shopType,
    String? city,
    String? houseNumber,
    String? street,
    String? postalCode,
    String? phoneNumber,
    String? website,
  ) {
    int nonNullCount = [
      description,
      shopType,
      city,
      houseNumber,
      street,
      postalCode,
      phoneNumber,
      website,
    ].where((element) => element != null).length;

    return (nonNullCount / 9 * 10).round();
  }
}
